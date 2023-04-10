//
//  Comment.swift
//  Generic Network Layer
//
//  Created by Caner Çağrı on 10.04.2023.
//

import Foundation


struct Comment: Codable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID
        case id, name, email, body
    }
}

