//
//  EndpointProtocol.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: [String: Any?]? { get }
}
