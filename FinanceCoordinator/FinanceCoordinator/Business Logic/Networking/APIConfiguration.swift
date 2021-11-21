//
//  APIConfiguration.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation

protocol APIConfiguration {
    var baseURL: BaseURL { get }
    var path: String? { get }
    var commonHeaders: CommonHeaders? { get }
    var customHeaders: [(String, String)]? { get }
    var body: [String: Any]? { get }
    var method: HttpMethod { get }
    var needAuth: Bool { get }
    var urlParameters: [String: String]? { get }
    var sequence: [Int] { get }
}

enum CommonHeaders {
    case NYTIMES
    case ALPHA
    case YAHOO
    
    var headers: [String: String]? {
        switch self {
        case .NYTIMES:
            return [HTTPHeaderField.nyAuth.rawValue : APIKeys.NYTIMES_KEY.rawValue]
        case .ALPHA:
            return [HTTPHeaderField.alphaAuth.rawValue : APIKeys.APLHA_KEY.rawValue]
        case .YAHOO:
            return [
                HTTPHeaderField.acceptType.rawValue : ContentType.json.rawValue,
                HTTPHeaderField.yahooAuth.rawValue : APIKeys.YAHOO_KEY.rawValue
            ]
        }
    }
}

enum BaseURL {
    case NYTIMES
    case ALPHA
    case YAHOO
    case custom(url: String)
    
    var description: String {
        switch self {
        case .NYTIMES:
            return "https://api.nytimes.com/svc/topstories/v2/"
        case .ALPHA:
            return "https://www.alphavantage.co/"
        case .YAHOO:
            return "https://yfapi.net/"
        case .custom(let url):
            return url
        }
    }
}

public enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

enum HTTPHeaderField: String {
    // Common
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case connection = "Connection"
    
    case nyAuth = "api-key"
    case alphaAuth = "apikey"
    case yahooAuth = "X-API-KEY"
}

enum ContentType: String {
    case urlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
}

enum ConnectionType: String {
    case keepAlive = "keep-alive"
}

enum APIKeys: String {
    case NYTIMES_KEY = "AiwbjS83wNgGhw42adrbMN8d1ahqsXXc"
    case APLHA_KEY = "HP9G563DD24ITCUM"
    case YAHOO_KEY = "T3p2fLxkp12QcOTRk8Jyx72XD6hywsP9arI7RTI5"
}
