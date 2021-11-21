//
//  Chart.swift
//  NewsApp
//
//  Created by Marinò, Marco on 17/11/21.
//

import Foundation

struct ChartResponse: Codable {
    let chart: ChartType?
}

struct ResultChart: Codable {
    let timestamp: [Int]?
    let meta: Meta?
    let indicators: Quote?
}

struct ChartType: Codable {
    let result: [ResultChart]?
}

struct Indicator: Codable {
    let high: [Float]?
    let low: [Float]?
    let open: [Float]?
    let close: [Float]?
}

struct Quote: Codable {
    let quote: [Indicator]?
}

struct Meta: Codable {
    let currency: String
    let symbol: String
    let regularMarketTime: Int
    let exchangeTimezoneName: String
}

enum ChartRange: String {
    case week = "5d"
    case month = "1mo"
    case year = "1y"
    case all = "max"
    
    static func getRange(_ index: Int) -> ChartRange {
        switch index {
        case 1: return .month
        case 2: return .year
        case 3: return .all
        default: return .week
        }
    }
    
    static func getIndex(_ range: ChartRange) -> Int {
        switch range {
        case .week: return 0
        case .month: return 1
        case .year: return 2
        case .all: return 3
        }
    }
}

