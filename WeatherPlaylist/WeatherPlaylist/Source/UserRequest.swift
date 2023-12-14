//
//  UserRequest.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
//MARK: - 프로토콜 작성 예시
enum HTTPRequest {
    case getUserInfo // 유저정보
    case getUsersPlayList // 유저 플레이리스트 가져오기
    case serchPlaylist(query: String) //검색하기
    case serchTracks(trackId: String) //플레이리스트 불러오기
    case userContains(ids: String, uid: String) // Like 여부 알려주기
    case likePlaylist(id: String)
    case deletePlaylist(id: String)
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
        case .getUserInfo:
            path = "me"
            method = .get
            self.parameters = parameters
        case .serchPlaylist(let query):
            path = "search?query=\(query)&type=playlist"
            method = .get
            self.parameters = nil
        case .serchTracks(let id):
            path = "playlists/\(id)/tracks"
            method = .get
            self.parameters = parameters
        case .userContains(let ids, let uid):
            path = "playlists/\(ids)/followers/contains?ids=\(uid)"
            method = .get
            self.parameters = nil
        case .likePlaylist(let id):
            path = "playlists/\(id)/followers"
            method = .put
            self.parameters = ["public": true]
        case .deletePlaylist(let id):
            path = "playlists/\(id)/followers"
            method = .delete
            self.parameters = nil
        case .getUsersPlayList:
            path = "me/playlists"
            method = .get
            self.parameters = nil
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
