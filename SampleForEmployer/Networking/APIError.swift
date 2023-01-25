//
//  APIError.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

enum APIError: Error {
    case noData
    case noResponse(String, String?, Int?)
    case notFound
    case invalidToken
    case invalidRequest
    case parsingError(error: Error)
    case serverError(error: Error)
    case oldVersion
}
