//
//  FinanceRouter.swift
//  NewsApp
//
//  Created by Marinò, Marco on 16/11/21.
//

import Foundation

enum FinanceRouter: APIConfiguration {
    
    var sequence: [Int] {
        let acceptableCodes = Array(200..<300)
        
        return acceptableCodes
    }
    
    var baseURL: BaseURL {
        switch self {
        case .symbolSearch:
            return .ALPHA
        }
    }
    
    var urlParameters: [String : String]? {
        switch self {
        case .symbolSearch(let query):
            return  [
                "function": "SYMBOL_SEARCH",
                "keywords": query,
                "apikey": APIKeys.APLHA_KEY.rawValue
            ]
        }
    }
    
    var commonHeaders: CommonHeaders? {
        switch self {
        default: return nil
        }
    }
    
    var customHeaders: [(String, String)]? {
        switch self {
        default: return nil
        }
    }
    
    var body: [String : Any]? {
        switch self {
        default: return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        default: return .GET
        }
    }
    
    var needAuth: Bool {
        switch self {
        default: return true
        }
    }

    case symbolSearch(keywords: String)

    var path: String? {
        switch self {
        case .symbolSearch:
            return "query"
        }
    }

}
