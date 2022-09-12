//
//  Todo.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import Foundation

struct todo: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}
