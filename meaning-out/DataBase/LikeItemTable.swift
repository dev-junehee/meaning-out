//
//  LikeItemTable.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import Foundation
import RealmSwift

class LikeItemTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var lprice: String
    @Persisted var mallName: String
    @Persisted var image: String
    @Persisted var link: String
    @Persisted var isLike: Bool
    
    convenience init(id: ObjectId, title: String, lprice: String, mallName: String, image: String, link: String, isLike: Bool) {
        self.init()
        self.title = title
        self.lprice = lprice
        self.mallName = mallName
        self.image = image
        self.link = link
        self.isLike = isLike
    }
}
