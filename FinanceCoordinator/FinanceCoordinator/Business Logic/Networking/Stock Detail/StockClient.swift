//
//  StockClient.swift
//  NewsApp
//
//  Created by Marinò, Marco on 17/11/21.
//

import Foundation

class StockClient: URLRequestAPIClient {
    static func getChart(symbol: String, range: ChartRange, completion: @escaping (Result<ChartResponse, NetworkFailureReason>) -> Void) {
        
        performURLRequest(StockRouter.rangedChart(symbol: symbol, range: range.rawValue), completion: completion)
    }
    
    static func getInsights(symbol: String, completion: @escaping (Result<InsightResponse, NetworkFailureReason>) -> Void) {
        performURLRequest(StockRouter.insights(symbol: symbol), completion: completion)
    }
}
