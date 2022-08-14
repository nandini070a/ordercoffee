//
//  Webservice.swift
//  OrderOwnCoffee
//
//  Created by Nandini Saha on 2022-03-24.
//

import Foundation

enum NetworkError: Error {
    case domainError
    case urlError
    case parsingError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    
    init(_ url: URL) {
        self.url = url
    }
}

struct Webservice {
    func fetch<T>(resource: Resource<T>, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.urlError))
                return
            }
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {return}
            DispatchQueue.main.async {
                completionHandler(.success(result))
            }
        }.resume()
    }
}
