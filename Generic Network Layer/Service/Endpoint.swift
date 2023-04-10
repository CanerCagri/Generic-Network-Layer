//
//  Endpoint.swift
//  Generic Network Layer
//
//  Created by Caner Çağrı on 10.04.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    
    func request() -> URLRequest
}

enum Endpoint {
    case getUsers
    case comments
}

extension Endpoint: EndpointProtocol {
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .comments:
            return "/comments"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .comments:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseUrl) else { fatalError("Url Error") }
        
        components.path = path
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        if let header = header {
            for(key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
