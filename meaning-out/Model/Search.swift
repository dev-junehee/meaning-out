//
//  SearchItem.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import Foundation

struct SearchResult: Decodable {
    let total: Int
    let start: Int
    let items: [SearchItem]
}

struct SearchItem: Decodable {
    let productId: String
    let title: String
    let lprice: String
    let mallName: String
    let image: String
    let link: String
    var isLike: Bool
    
    enum CodingKeys: CodingKey {
        case productId
        case title
        case lprice
        case mallName
        case image
        case link
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        productId = try container.decode(String.self, forKey: .productId)
        title = try container.decode(String.self, forKey: .title)
        lprice = try container.decode(String.self, forKey: .lprice)
        mallName = try container.decode(String.self, forKey: .mallName)
        image = try container.decode(String.self, forKey: .image)
        link = try container.decode(String.self, forKey: .link)
        isLike = false
    }
}
