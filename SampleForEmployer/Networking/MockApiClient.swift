//
//  MockApiClient.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

struct MockApiClient: APIClientProtocol {
    func perform<T>(endpoint: EndpointProtocol, complete: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
    }
}
