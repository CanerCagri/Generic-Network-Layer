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
    var parameters: [String: Any]? {get}
    
    func request() -> URLRequest
}

enum Endpoint {
    case getUsers
    case comments(postId: String)
    case posts(title: String, body: String, userId: Int)
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
        case .posts:
            return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .comments:
            return .get
        case .posts:
            return .post
        }
    }
    
    var header: [String : String]? {
        let header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
        return header
    }
    
    var parameters: [String : Any]? {
        if case .posts(let title, let body, let userId) = self {
            return ["title": title, "body": body, "userId": userId]
        }
        
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseUrl) else { fatalError("Url Error") }
        
        //MARK: Add QueryItem
        if case .comments(let id) = self {
            components.queryItems = [URLQueryItem(name: "postId", value: id)]
        }
        
        //MARK: Add Path
        components.path = path
        
        //MARK: Create Request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //MARK: Add Parameters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }

        }
        
        //MARK: Add Header
        if let header = header {
            for(key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
