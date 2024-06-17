//
//  SearchItem.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import Foundation

struct SearchResult {
    let total: Int
    let items: [SearchItem]
}

struct SearchItem {
    let title: String
    let lprice: String
    let mallName: String
    let image: String
}
