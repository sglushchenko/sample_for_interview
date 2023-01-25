//
//  UserApiServiceProtocol.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

protocol UserApiServiceProtocol {
    
    /// Fetch users from server by page
    ///
    /// `page` is set page which you want fetch
    /// `complete` is closer with array of `Users`
    ///
    
    func getAllUsers(page: Int, complete: @escaping (Result<PageResponse<User>, APIError>) -> Void)
}
