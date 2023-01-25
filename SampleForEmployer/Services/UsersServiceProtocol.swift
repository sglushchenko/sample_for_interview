//
//  UsersServiceProtocol.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

protocol UsersServiceProtocol {
    func loadUsers(page: Int, complete: @escaping (_ result: Result<PageResponse<User>, APIError>) -> Void)
}
