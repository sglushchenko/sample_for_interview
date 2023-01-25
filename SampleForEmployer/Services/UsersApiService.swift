//
//  UsersApiService.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

class UserApiService: UserApiServiceProtocol {
    private let client: APIClientProtocol
    
    init(with client: APIClientProtocol = APIClient(basePath: "users")) {
        self.client = client
    }
    
    private enum UserEndpoint: EndpointProtocol {
        var path: String {
            switch self {
            case .allUsers(let page): return "?users=\(page)"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .allUsers: return .get
            }
        }
        
        var body: [String : Any?]? {
            switch self {
            case .allUsers: return nil
            }
        }
        
        case allUsers(Int)
    }
    
    func getAllUsers(page: Int, complete: @escaping (Result<PageResponse<User>, APIError>) -> Void) {
        client.perform(endpoint: UserEndpoint.allUsers(page), complete: complete)
    }
}
