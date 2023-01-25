//
//  UsersServiceProtocol.swift
//  SampleForIntreview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

protocol UsersServiceProtocol {
    
    /// Fetch users by page
    ///
    /// `page` is set page which you want fetch
    /// `complete` is  handler with array of users
    func loadUsers(page: Int, complete: @escaping (_ result: Result<PageResponse<User>, APIError>) -> Void)
}
