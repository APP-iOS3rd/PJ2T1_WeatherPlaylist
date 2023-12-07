//
//  CachedImage.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
import SwiftUI
public struct CachedImage<Content>: View where Content: View {
    @State private var phase: AsyncImagePhase
    private let urlRequest: URLRequest?
    private let urlSession: URLSession
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    public var body: some View {
        content(phase)
            .task(id: urlRequest, load)
    }
    public init(url: URL?,
                urlCache: URLCache = .shared,
                scale: CGFloat = 1,
                transaction: Transaction = Transaction(),
                @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale, transaction: transaction, content: content)
    }
    //MARK: - init
    public init(urlRequest: URLRequest?,
                urlCache: URLCache = .shared,
                scale: CGFloat = 1,
                transaction: Transaction = Transaction(),
                @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        self.urlRequest = urlRequest
        self.urlSession =  URLSession(configuration: configuration)
        self.scale = scale
        self.transaction = transaction
        self.content = content
        
        self._phase = State(wrappedValue: .empty)
        do {
            if let urlRequest = urlRequest,
               let image = try cachedImage(from: urlRequest, cache: urlCache) {
                self._phase = State(wrappedValue: .success(image))
            }
        } catch {
            self._phase = State(wrappedValue: .failure(error))
        }
    }
    @Sendable
    private func load() async {
        do {
            if let urlRequest = urlRequest {
                let (image, metrics) = try await remoteImage(from: urlRequest, session: urlSession)
                if metrics.transactionMetrics.last?.resourceFetchType == .localCache {
                    // WARNING: This does not behave well when the url is changed with another
                    phase = .success(image)
                } else {
                    withAnimation(transaction.animation) {
                        phase = .success(image)
                    }
                }
            } else {
                withAnimation(transaction.animation) {
                    phase = .empty
                }
            }
        } catch {
            withAnimation(transaction.animation) {
                phase = .failure(error)
            }
        }
    }
}
private extension AsyncImage {
    struct LoadingError: Error {
        let description: String = "이미지 로딩에 실패했습니다."
    }
}
private extension CachedImage {
    private func remoteImage(from request: URLRequest, session: URLSession) async throws -> (Image, URLSessionTaskMetrics) {
         let (data, _, metrics) = try await session.data(for: request)
         if metrics.redirectCount > 0, let lastResponse = metrics.transactionMetrics.last?.response {
             let requests = metrics.transactionMetrics.map { $0.request }
             requests.forEach(session.configuration.urlCache!.removeCachedResponse)
             let lastCachedResponse = CachedURLResponse(response: lastResponse, data: data)
             session.configuration.urlCache!.storeCachedResponse(lastCachedResponse, for: request)
         }
         return (try image(from: data), metrics)
     }
     
     private func cachedImage(from request: URLRequest, cache: URLCache) throws -> Image? {
         guard let cachedResponse = cache.cachedResponse(for: request) else { return nil }
         return try image(from: cachedResponse.data)
     }
     
     private func image(from data: Data) throws -> Image {
         if let uiImage = UIImage(data: data, scale: scale) {
             return Image(uiImage: uiImage)
         } else {
             throw AsyncImage<Content>.LoadingError()
         }
     }
 }
private class URLSessionTaskController: NSObject, URLSessionTaskDelegate {
    var metrics: URLSessionTaskMetrics?
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        self.metrics = metrics
    }
}
private extension URLSession {
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse, URLSessionTaskMetrics) {
        let controller = URLSessionTaskController()
        let (data, response) = try await data(for: request, delegate: controller)
        return (data, response, controller.metrics!)
    }
}
