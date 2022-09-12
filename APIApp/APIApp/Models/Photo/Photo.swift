//
//  Photo.swift
//  APIApp
//
//  Created by Владислав on 4.09.22.
//

import Foundation

struct Photo: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
