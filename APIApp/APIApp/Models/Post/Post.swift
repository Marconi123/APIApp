//
//  Posts.swift
//  APIApp
//
//  Created by Владислав on 4.09.22.
//

import Foundation

struct Post: Codable, CaseIterable {
    
    static var allCases: [Post] = []
    
    let userId: Int?
    let title: String?
    let body: String?
}
