//
//  StockRouter.swift
//  NewsApp
//
//  Created by Marinò, Marco on 17/11/21.
//

import Foundation

enum StockRouter: APIConfiguration {
    
    var sequence: [Int] {
        let acceptableCodes = Array(200..<300)
        
        return acceptableCodes
    }
    
    var baseURL: BaseURL {
        switch self {
        default: return .YAHOO
        }
    }
    
    var urlParameters: [String : String]? {
        switch self {
        case .rangedChart(_, let range):
            return  [
                "region": "US",
                "lang": "en",
                "range": range,
                "interval": "1d",
                "events" : "div%2Csplit"
            ]
        case .insights(let symbol):
            return [
                "symbol": symbol
            ]
        }
    }
    
    var commonHeaders: CommonHeaders? {
        switch self {
        default:
            return .YAHOO
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

    case rangedChart(symbol: String, range: String)
    case insights(symbol: String)

    var path: String? {
        switch self {
        case .rangedChart(let symbol, _):
            return "v8/finance/chart/\(symbol)"
        case .insights: return "ws/insights/v1/finance/insights"
        }
    }

}
