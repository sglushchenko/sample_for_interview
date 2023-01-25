//
//  MockApiClient.swift
//  SampleForIntreview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

struct MockApiClient: APIClientProtocol {
    let result: Decodable?
    let error: APIError?
    
    init(expectedSuccessResult: Decodable) {
        self.result = expectedSuccessResult
        self.error = nil
    }
    
    init(expectedError: APIError) {
        self.error = expectedError
        self.result = nil
    }
    
    func perform<T>(endpoint: EndpointProtocol, complete: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        guard let error = self.error else {
            guard let result = result as? T else {
                complete(.failure(.noData))
                return
            }
            
            complete(.success(result))
            return
        }
        
        complete(.failure(error))
    }
}
