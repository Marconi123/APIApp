//
//  Comment.swift
//  APIApp
//
//  Created by Владислав on 4.09.22.
//

import Foundation

struct Comment: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
