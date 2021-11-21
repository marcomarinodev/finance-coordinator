//
//  NetworkFailureReason.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation

public enum NetworkFailureReason: Error {
    case applicativeFailureString(message: String, statusCode: String)
    case applicativeFailureInt(message: String, statusCode: Int)
    case genericFailed(error: Error, statusCode: Int)
    case serviceError(title: String, message: String, statusCode: Int?)
    case genericNetworkFailure
    case badUrl
    case missingData
    case connectionAbsent
    case invalidParameters(Error)
    case jsonParsingError(Error)
    case firebaseError(Error)
}
