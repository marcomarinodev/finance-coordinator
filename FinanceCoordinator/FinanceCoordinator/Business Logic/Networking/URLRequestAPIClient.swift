//
//  URLRequestAPIClient.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation
import UIKit

class URLRequestAPIClient {
    
    private static let shared = URLRequestAPIClient()
    
    static let cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    static let timeoutInterval: TimeInterval = 60.0
    
    private static var sessionExpiresTimer: Timer?
    static var isSessionValid: Bool {
        return sessionExpiresTimer?.isValid ?? true
    }
    
    static func performURLRequest<T: Decodable>(_ route: APIConfiguration, completion: @escaping (Result<T, NetworkFailureReason>) -> Void) {
        performURLRequestInternal(route, customHeader: route.customHeaders, completion: completion)
    }
    
    static func performURLRequestInternal<T: Decodable>(_ route: APIConfiguration, customHeader: [(String, String)]?, completion: @escaping (Result<T, NetworkFailureReason>) -> Void) {
        
        guard let baseURL = URL(string: route.baseURL.description) else {
            print("Bad Url")
            completion(.failure(.badUrl))
            return
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        
        if let path = route.path {
            components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        }
        
        if let parameters = route.urlParameters {
            components?.queryItems = parameters.sorted { $0.0 < $1.0 }.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            
            let percentEncodingQuery = components?.percentEncodedQuery
            components?.percentEncodedQuery = percentEncodingQuery?.replacingOccurrences(of: " ", with: "%20")
        }
        
        guard let url = components?.url else {
            print("Generic Url Failure")
            completion(.failure(.genericNetworkFailure))
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeoutInterval)
        urlRequest.httpMethod = route.method.rawValue
        
        route.commonHeaders?.headers?.forEach({ (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        route.customHeaders?.forEach({ (field: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: field)
        })
        
        print("Sending URL Request: \(urlRequest.description)")
        
        // Execute request
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let response = response as? HTTPURLResponse, route.sequence.contains(response.statusCode) {
                
                guard var data = data else {
                    DispatchQueue.main.async {
                        print("Missing data")
                        completion(.failure(.missingData))
                    }
                    return
                }

                do {
                    if data.isEmpty, let emptyJson = "{}".data(using: .utf8) {
                        data = emptyJson
                    }
                    
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(decodedObject))
                    }
                    
                } catch {
                    
                    DispatchQueue.main.async {
                        print("Json Parsing Error")
                        completion(.failure(.jsonParsingError(error)))
                    }
                    
                }
            } else {
                
                DispatchQueue.main.async {
                    print("Bad Status")
                    completion(.failure(.genericNetworkFailure))
                }
            }
            
        }.resume()
        
    }
    
    static func downloadFile(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
}
