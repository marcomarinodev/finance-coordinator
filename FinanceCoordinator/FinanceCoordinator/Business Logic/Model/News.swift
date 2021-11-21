//
//  News.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation

struct ResultNews: Codable, Equatable {
    var status: String
    var lastUpdated: String
    var numResults: Int
    var results: [News]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case lastUpdated = "last_updated"
        case numResults = "num_results"
        case results
    }
}

struct News: Codable, Equatable {
    var section: String
    var title: String
    var by: String
    var date: String
    var media: [Multimedia]?
    var abstract: String
    
    private enum CodingKeys: String, CodingKey {
        case section
        case title
        case by = "byline"
        case date = "published_date"
        case abstract
        case media = "multimedia"
    }
    
    static func mockNews() -> [News] {
        return [
            News(section: "Climate", title: "6 takeaways from the U.N. climate conference", by: "Mark", date: "dd/mm/yyyy", media: nil, abstract: ""),
            News(section: "Climate", title: "6 takeaways from the U.N. climate conference", by: "Mark", date: "dd/mm/yyyy", media: nil, abstract: ""),
            News(section: "Climate", title: "6 takeaways from the U.N. climate conference", by: "Mark", date: "dd/mm/yyyy", media: nil, abstract: ""),
            News(section: "Climate", title: "6 takeaways from the U.N. climate conference", by: "Mark", date: "dd/mm/yyyy", media: nil, abstract: ""),
            News(section: "Climate", title: "6 takeaways from the U.N. climate conference", by: "Mark", date: "dd/mm/yyyy", media: nil, abstract: ""),
            News(section: "Climate", title: "6 takeaways from the U.N. climate conference", by: "Mark", date: "dd/mm/yyyy", media: nil, abstract: "")
        ]
    }
}
