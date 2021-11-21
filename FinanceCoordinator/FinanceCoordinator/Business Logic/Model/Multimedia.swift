//
//  Multimedia.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation

struct Multimedia: Codable, Equatable {
    var imageURL: String
    var copyright: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "url", copyright
    }
    
}
