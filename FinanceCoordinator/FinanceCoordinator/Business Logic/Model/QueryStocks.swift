//
//  Stock.swift
//  NewsApp
//
//  Created by Marinò, Marco on 16/11/21.
//

import Foundation

struct ResultQueryStocks: Codable, Equatable {
    var bestMatches: [QueryStocks]?
    
    private enum CodingKeys: String, CodingKey {
        case bestMatches
    }
}

struct QueryStocks: Codable, Equatable {
    var symbol: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol", name = "2. name"
    }
}
