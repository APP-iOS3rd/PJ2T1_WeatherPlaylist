//
//  UserRequest.swift
//  WeatherPlaylist
//
//  Created by 김태훈 on 12/6/23.
//

import Foundation
//MARK: - 프로토콜 작성 예시
class UserRequest<T>: APIRequestProtocol where T: Decodable{
    typealias Response = T
    var path: String = "me"
    var method: HTTPMethod = .get
    var parameters: [String: Any]? = ["key": "value"]
    init(path: String = "me",
         method: HTTPMethod = .get,
         parameters: [String : Any]? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
    }
    //User API에서 사용되는 case별로 enum으로 관리하면 편할듯..?
    enum apiType {
        case myinfo
        case myPlayList
    }
    func mapResponseToModel() async -> Response?{
        do {
           let tmp = await fetchData()
            switch tmp {
            case .success(let response) :
                return response
            case .failure(let error) :
                print(error.errorDescription)
                return nil
            }
        }
    }
}
//MARK: - 임시모델
struct TMP: Decodable{
    let id: UUID
}
