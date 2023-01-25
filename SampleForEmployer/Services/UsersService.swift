//
//  UsersService.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

final class UsersService: UsersServiceProtocol {
    
    let client: UserApiServiceProtocol
    
    init(client: UserApiServiceProtocol = UserApiService()) {
        self.client = client
    }
    
    func loadUsers(page: Int = 0, complete: @escaping (_ result: Result<PageResponse<User>, APIError>) -> Void) {
        client.getAllUsers(page: page, complete: complete)
    }
}
