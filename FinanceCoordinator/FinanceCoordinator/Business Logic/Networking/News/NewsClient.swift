//
//  NewsClient.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation
import UIKit

class NewsClient: URLRequestAPIClient {
    
    static func getScienceNews(siteID: String, completion: @escaping (Result<ResultNews, NetworkFailureReason>) -> Void) {
        performURLRequest(NewsRouter.scienceNews, completion: completion)
    }
    
    static func getWorldNews(siteID: String, completion: @escaping (Result<ResultNews, NetworkFailureReason>) -> Void) {
        performURLRequest(NewsRouter.worldNews, completion: completion)
    }
    
    static func getHealthNews(siteID: String, completion: @escaping (Result<ResultNews, NetworkFailureReason>) -> Void) {
        performURLRequest(NewsRouter.healthNews, completion: completion)
    }
    
    static func getSportsNews(siteID: String, completion: @escaping (Result<ResultNews, NetworkFailureReason>) -> Void) {
        performURLRequest(NewsRouter.sportsNews, completion: completion)
    }
    
}
