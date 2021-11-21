//
//  InsightsResponse.swift
//  NewsApp
//
//  Created by Marinò, Marco on 19/11/21.
//

import Foundation

struct InsightResponse: Codable, Equatable {
    let finance: FinanceResult
}

struct FinanceResult: Codable, Equatable {
    let result: GenericReportResult
}

struct GenericReportResult: Codable, Equatable {
    let reports: [Report]?
}

struct Report: Codable, Equatable {
    let title: String
    let publishedDate: String
    let summary: String
    let author: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case publishedDate = "publishedOn"
        case summary
        case author = "provider"
    }
}
