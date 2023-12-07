//
//  UserRequest.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
//MARK: - 프로토콜 작성 예시
enum HTTPRequest {
    case login
    case getUserInfo
    case serchPlaylist(query: String)
    case serchTracks(trackId: String)
    case userContains
}
final class HTTPManager<T>: APIRequestProtocol where T: Decodable{
    typealias Response = T
    var path: String
    var method: HTTPMethod
    var parameters: [String : Any]?
    var apiType: HTTPRequest
    init(apiType: HTTPRequest, parameters: [String : Any]? = nil) {
        self.apiType = apiType
        switch apiType {
        case .login:
            path = "me"
            method = .get
            self.parameters = parameters
        case .getUserInfo:
            path = ""
            method = .get
            self.parameters = parameters
        case .serchPlaylist(let query):
            path = "search"
            method = .get
            self.parameters = ["q": query]
        case .serchTracks(let id):
            path = "tracks/\(id)"
            method = .get
            self.parameters = parameters
        case .userContains:
            path = "me"
            method = .get
            self.parameters = parameters
        }
    }
    //이 함수의 존재 이유가..?
    func fetchDataModel() async -> Response? {
        do {
           let tmp = await fetchData()
            switch tmp {
            case .success(let response) :
                return response
            case .failure(let error) :

//                switch error {
//                case .urlError(_):
//
//                case .decodingError(_):
//
//                case .otherError:
//
//                case .httpError(_):
//
//                }
                print(error.errorDescription)
                return nil
            }
        }
    }
}

//MARK: - 이런식
struct UserData: Decodable{
    let id: UUID
}
func test() async {
    let manager = HTTPManager<UserData>(apiType: .serchPlaylist(query: "happy"))
    let result = await manager.fetchData()
    switch result {
    case .success(let res):
        print("\(res.id)")
    case .failure(_):
        print("실패")
    }
}
