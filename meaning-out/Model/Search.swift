//
//  SearchItem.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import Foundation

struct SearchResult: Codable {
    let total: Int
    let start: Int
    let items: [SearchItem]
}

struct SearchItem: Codable {
    let title: String
    let lprice: String
    let mallName: String
    let image: String
}
