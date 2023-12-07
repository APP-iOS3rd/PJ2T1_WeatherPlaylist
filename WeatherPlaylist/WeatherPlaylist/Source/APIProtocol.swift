//
//  APIProtocol.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
protocol APIProtocol {
    var baseURL: String { get }
    var clientID: String { get }
    var clientSecret: String { get }
}
extension APIProtocol {
    var clientID: String {
        Bundle.main.object(forInfoDictionaryKey: "ClientID") as? String ?? ""
    }
    var clientSecret: String {
        Bundle.main.object(forInfoDictionaryKey: "ClientPW") as? String ?? ""
    }
    var baseURL: String {
        return "https://api.spotify.com/v1/"
    }
    var headers: [String: String]? {
        // 토큰을 저장하는 프로세스도 필요합니다
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return ["Content-Type": "application/json"]
        }
        
        return ["Authorization": "Bearer \(token)",
                "Content-Type": "application/json"]
    }
}
protocol APIRequestProtocol: APIProtocol {
    associatedtype Response: Decodable
    var path: String { get set }
    var method: HTTPMethod { get set }
    var parameters: [String: Any]? { get set }
}
extension APIRequestProtocol {
    var url: String {
        baseURL + path
    }
    func fetchData() async -> Result<Response, APIError> {
        do {
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = method.rawValue
            // 필요한 경우 헤더 추가
            if let headers = headers {
                for (key, value) in headers {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }
            // 필요한 경우 파라미터 추가
            if let parameters = parameters {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                urlRequest.httpBody = jsonData
            }
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // 에러 처리 - 상태 코드 확인
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.otherError)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                // 성공적인 상태 코드
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(Response.self, from: data)
                return .success(decodedResponse)
            case 400:
                return .failure(.httpError(.badRequestError))
            case 401, 403:
                return .failure(.httpError(.authError))
            case 404:
                return .failure(.httpError(.notFoundError))
            case 500...505 :
                return .failure(.httpError(.serverError))
            default:
                // 에러 상태 코드
                return .failure(.httpError(.serverError))
            }
        } catch let urlError as URLError {
            return .failure(.urlError(urlError))
        } catch let decodingError as DecodingError {
            return .failure(.decodingError(decodingError))
        } catch {
            return .failure(.otherError)
        }
    }
}
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
enum APIError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case otherError
    case httpError(HTTPError)
    var errorDescription: String {
        switch self{
        case .urlError(let urlError):
            urlError.localizedDescription
        case .decodingError(let decodingError):
            decodingError.errorDescription ?? "디코딩 오류"
        case .otherError:
           "알 수 없는 오류입니다."
        case .httpError(let httpError):
            switch httpError {
            case .serverError:
                "서버 내부의 오류입니다."
            case .badRequestError:
                "리퀘스트 오류입니다."
            case .authError:
                "권한이 없습니다"
            case .notFoundError:
                "정보가 없습니다"
            }
        }
    }
}
enum HTTPError: Error{
    case serverError
    case badRequestError
    case authError
    case notFoundError
}
