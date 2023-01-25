//
//  HTTPMethod.swift
//  SampleForInterview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

enum HTTPMethod: String {
    case get, post, patch, delete
    
    var name: String { rawValue.uppercased() }
}
