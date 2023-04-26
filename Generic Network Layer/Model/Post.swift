//
//  Post.swift
//  Generic Network Layer
//
//  Created by Caner Çağrı on 26.04.2023.
//

import Foundation

struct Post: Codable {
    let id: Int?
    let title: String?
    let body: String?
    let userId: Int?
}
