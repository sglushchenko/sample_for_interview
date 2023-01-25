//
//  ApiClient.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import Foundation

struct APIClient {
    private let session = URLSession.shared
    
    private let baseURL: String
    private let basePath: String
    
    init(basePath: String) {
        self.baseURL = "\(Config.baseURL)api/"
        self.basePath = basePath
    }
    
    func perform<T: Decodable>(endpoint: EndpointProtocol, complete: @escaping (_ result: Result<T, APIError>) -> Void) {
        let decoder = JSONDecoder()
        
        let path = "\(endpoint.method.rawValue.uppercased()) \(basePath)/\(endpoint.path)"
        
        guard let request = request(for: endpoint, token: "") else {
            complete(.failure(APIError.invalidRequest))
            return
        }
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                complete(.failure(APIError.noResponse("\(path)", "", nil)))
                return
            }

            guard 404 != httpResponse.statusCode else {
                complete(.failure(APIError.notFound))
                return
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                complete(.failure(APIError.noResponse("\(path)", "", httpResponse.statusCode)))
                return
            }
            
            guard 426 != httpResponse.statusCode else {
                complete(.failure(APIError.oldVersion))
                return
            }

            guard let data = data else {
                complete(.failure(APIError.noResponse("\(path)", "", nil)))
                return
            }
            
            var resultData = data
            if T.self == NoResponse.self && data.isEmpty {
                resultData = "{}".data(using: .utf8) ?? Data()
            } else if T.self == PlainResponse.self {
                let dataString = String(data: data, encoding: .utf8) ?? ""
                let dictionary = ["data": dataString]
                resultData = (try? JSONSerialization.data(withJSONObject: dictionary)) ?? Data()
            }
            
            do {
                let result = try decoder.decode(T.self, from: resultData)
                DispatchQueue.main.async {
                    complete(.success(result))
                }
            } catch let error {
                DispatchQueue.main.async {
                    complete(.failure(.parsingError(error: error)))
                }
            }
        }
        
        task.resume()
    }
    
    private func request(for endpoint: EndpointProtocol, token: String) -> URLRequest? {
        guard let url = URL(string: "\(baseURL)\(basePath)/\(endpoint.path.replacingOccurrences(of: " ", with: "%20"))") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.name
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        #if DEBUG
        let path = "\(endpoint.method.rawValue.uppercased()) \(basePath)/\(endpoint.path)"
        print("REQUEST: \(path)")
        #endif

        // Add option .withoutEscapingSlashes because it make url from https://google.com to https:\/\/google.com and for server this url not valid
        if let body = endpoint.body, let httpBody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted]) {
            request.httpBody = httpBody

            #if DEBUG
            if let s = String(data: httpBody, encoding: .utf8) {
                print(s)
            }
            #endif
        }
        
        return request
    }
}

struct NoResponse: Decodable {}

struct PlainResponse: Decodable {
    let data: String?
}

struct PageResponse<T: Decodable>: Decodable {
    let data: [T]
}
