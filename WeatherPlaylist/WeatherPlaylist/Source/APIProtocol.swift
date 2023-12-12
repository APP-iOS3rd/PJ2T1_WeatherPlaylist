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
        guard let token = UserDefaults.standard.string(forKey: "AccessToken") else {
            return nil
        }
        //토큰이 왜..?
//        return ["Authorization" : "Bearer BQB_HvjDJmw3naMYFOcOQtjO3J34mCBUwBl3lJTkI57r7hL0R0PJjZ1kybSiBaHj3QwLFp9eVYlcK5hBLYM4ObMqyedoMtgIWNnTP_URnKvf0QTyoO0"]
        return ["Authorization" : "Bearer \(token)"]
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
    private func isRefreshTokenSuccessed() async -> Bool{
        guard let refreshToken = UserDefaults.standard.string(forKey: "RefreshToken") else {return false}
        let refreshParams = [
            "grant_type" : "refresh_token",
            "refresh_token" : refreshToken]
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "accounts.spotify.com"
        components.path = "/api/token"
        components.queryItems = refreshParams.map({URLQueryItem(name: $0, value: $1)})
        guard let url = components.url else { return false}
        var urlRequest = URLRequest(url: url)
        let auth = Data("\(clientID):\(clientSecret)".utf8).base64EncodedString()
        urlRequest.setValue("Basic " + auth, forHTTPHeaderField: "Authorization")

        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                return false
            }
            switch httpResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AccessToken.self, from: data)
                UserDefaults.standard.removeObject(forKey: "AccessToken")
                UserDefaults.standard.removeObject(forKey: "RefreshToken")
                UserDefaults.standard.setValue(decodedResponse.token, forKey: "AccessToken")
                UserDefaults.standard.setValue(decodedResponse.refreshToken, forKey: "RefreshToken")
                return true
            default:
                UserDefaults.standard.removeObject(forKey: "AccessToken")
                UserDefaults.standard.removeObject(forKey: "RefreshToken")
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("JSON Response: \(json ?? [:])")
                return false
            }
        } catch {
            UserDefaults.standard.removeObject(forKey: "AccessToken")
            UserDefaults.standard.removeObject(forKey: "RefreshToken")
            return false
        }
    }
    func fetchData() async -> Result<Response, APIError> {
        var failedData: Data? = nil
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
                failedData = data

                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(Response.self, from: data)
                failedData = nil

                return .success(decodedResponse)
            case 400:
                print(httpResponse.description)
                return .failure(.httpError(.badRequestError))
            case 401, 403:
                if await isRefreshTokenSuccessed() {
                    SigningManager.shared.isLogout = false
                    return await fetchData()
                } else {
                    //MARK: - 이거 삭제가 맞는 것 같습니다
//                    UserDefaults.standard.removeObject(forKey: "AccessToken")
//                    UserDefaults.standard.removeObject(forKey: "RefreshToken")
                    SigningManager.shared.isLogout = true
                    return .failure(.httpError(.authError))
                }
                // token refresh 하는 로직
            case 404:
                return .failure(.httpError(.notFoundError))
            case 500...505 :
                return .failure(.httpError(.serverError))
            default:
                return .failure(.httpError(.serverError))
            }
        } catch let urlError as URLError {
            return .failure(.urlError(urlError))
        } catch let decodingError as DecodingError {
            if let failed = failedData {
                do {
                    let json = try JSONSerialization.jsonObject(with: failed, options: []) as? [String: Any]
                    print("JSON Response: \(json ?? [:])")
                    failedData = nil
                    // Try decoding your model here
                } catch let error {
                    failedData = nil
                    print("Error decoding JSON: \(error)")
                }
            }
            print(decodingError.localizedDescription)
            print(decodingError.failureReason)
            print(decodingError.errorDescription)

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
            decodingError.failureReason ?? "디코딩 오류"
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
