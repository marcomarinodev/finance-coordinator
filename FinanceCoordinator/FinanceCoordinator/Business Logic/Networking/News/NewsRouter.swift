//
//  NewsRouter.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation
import UIKit

enum NewsRouter: APIConfiguration {
    
    var sequence: [Int] {
        let acceptableCodes = Array(200..<300)
        
        switch self {
        default: return acceptableCodes
        }
    }
    
    var baseURL: BaseURL {
        switch self {
        case .healthNews, .sportsNews, .scienceNews, .worldNews:
            return .NYTIMES
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
        default:
            return true
        }
    }
    
    var urlParameters: [String : String]? {
        switch self {
        default:
            return ["api-key": APIKeys.NYTIMES_KEY.rawValue]
        }
    }
    
    case sportsNews
    case scienceNews
    case worldNews
    case healthNews
    
    var path: String? {
        switch self {
        case .sportsNews:
            return "sports.json"
        case .scienceNews:
            return "science.json"
        case .worldNews:
            return "world.json"
        case .healthNews:
            return "health.json"
        }
    }
    
}
