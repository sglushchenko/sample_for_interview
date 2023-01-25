//
//  UsersService.swift
//  SampleForIntreview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

final class UsersService: UsersServiceProtocol {
    
    let client: UserApiServiceProtocol
    
    init(client: UserApiServiceProtocol = UserApiService()) {
        self.client = client
    }
    
    /// Fetch users by page
    ///
    /// `page` is set page which you want fetch
    /// `complete` is  handler with array of users
    func loadUsers(page: Int = 0, complete: @escaping (_ result: Result<PageResponse<User>, APIError>) -> Void) {
        client.getAllUsers(page: page, complete: complete)
    }
}
