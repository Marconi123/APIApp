//
//  M2.swift
//  APIApp
//
//  Created by Владислав on 31.08.22.
//

import Foundation

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}
