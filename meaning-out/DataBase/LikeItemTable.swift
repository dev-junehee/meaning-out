//
//  LikeItemTable.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import Foundation
import RealmSwift

class LikeItemTable: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var lprice: String
    @Persisted var mallName: String
    @Persisted var image: String
    @Persisted var link: String
    @Persisted var isLike: Bool
    
    convenience init(item: SearchItem) {
        self.init()
        self.id = item.productId
        self.title = item.title
        self.lprice = item.lprice
        self.mallName = item.mallName
        self.image = item.image
        self.link = item.link
        self.isLike = true
    }
}
