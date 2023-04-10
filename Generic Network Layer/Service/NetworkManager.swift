//
//  NetworkManager.swift
//  Generic Network Layer
//
//  Created by Caner Çağrı on 10.04.2023.
//

import Foundation

// https://jsonplaceholder.typicode.com/users

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error as NSError))
            }
        }
        
        task.resume()
    }
    
    func getUser(completion: @escaping (Result<[User], Error>) -> Void) {
        
        let endPoint = Endpoint.getUsers
        request(endpoint: endPoint, completion: completion)
    }
    
    func getComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        
        let endPoint = Endpoint.comments
        request(endpoint: endPoint, completion: completion)
    }
}
