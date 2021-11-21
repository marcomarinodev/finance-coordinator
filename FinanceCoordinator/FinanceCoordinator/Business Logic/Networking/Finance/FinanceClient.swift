//
//  FinanceClient.swift
//  NewsApp
//
//  Created by Marinò, Marco on 16/11/21.
//

import Foundation
import UIKit

class FinanceClient: URLRequestAPIClient {
    
    static func getStocks(query: String, completion: @escaping (Result<ResultQueryStocks, NetworkFailureReason>) -> Void) {
        
        performURLRequest(FinanceRouter.symbolSearch(keywords: query), completion: completion)
        
    }
    
}

