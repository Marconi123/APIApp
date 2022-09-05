//
//  ApiConstants.swift
//  APIApp
//
//  Created by Владислав on 4.09.22.
//

import UIKit

class ApiConstants {
    
    // Local server
    static let serverPath = "http://localhost:3000/"
    
    // posts
    static let postsPath = serverPath + "posts"
    static let postsPathURL = URL(string: postsPath)
    
    // comments
    static let commentsPath = serverPath + "comments"
    static let commentsPathURL = URL(string: commentsPath)
    
    // albums
    static let albumsPath = serverPath + "albums"
    static let albumsPathURL = URL(string: albumsPath)
    
    // todos
    static let todosPath = serverPath + "todos"
    static let todosPathURL = URL(string: todosPath)
    
    // photos
    static let photosPath = serverPath + "photos"
    static let photosPathURL = URL(string: photosPath)
    
    // users
    static let usersPath = serverPath + "users"
    static let usersPathURL = URL(string: usersPath)
}
