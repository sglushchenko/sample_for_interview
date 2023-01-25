//
//  APIClientProtocol.swift
//  SampleForInterview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

protocol APIClientProtocol {
    func perform<T: Decodable>(endpoint: EndpointProtocol, complete: @escaping (_ result: Result<T, APIError>) -> Void)
}
