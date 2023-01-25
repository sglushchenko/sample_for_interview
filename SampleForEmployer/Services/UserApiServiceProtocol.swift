//
//  UserApiServiceProtocol.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

protocol UserApiServiceProtocol {
    func getAllUsers(page: Int, complete: @escaping (Result<PageResponse<User>, APIError>) -> Void)
}
