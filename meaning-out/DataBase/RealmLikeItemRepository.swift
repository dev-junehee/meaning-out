//
//  LikeItemRepository.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import Foundation
import RealmSwift

final class RealmLikeItemRepository {
    
    private let realm = try! Realm()
    
    // 스키마 버전 확인
    func getSchemaVersion() {
        print(realm.configuration.schemaVersion)
    }
    
    // 저장 루트 확인하기
    func getFileURL() {
        print(realm.configuration.fileURL ?? "fileURL 없음")
    }
    
    // 찜 카테고리 가져오기
    func getAllLikeCategory() -> [LikeCategory] {
        let category = realm.objects(LikeCategory.self)
        return Array(category)
    }
    
    // 찜한 상품 저장하기
    func saveLikeItem(_ item: LikeItem) {
        do {
            try realm.write {
                realm.add(item)
                print("찜한 상품 저장 성공")
                getFileURL()
            }
        } catch {
            print(#function, "찜한 상품 저장 실패", error)
        }
    }
    
    // 찜한 상품 불러오기
    func getAllLikeItem() -> Results<LikeItem> {
        return realm.objects(LikeItem.self)
    }
    
    // 찜한 상품 찾기
    func findLikeItem(id: String) -> LikeItem {
        return realm.object(ofType: LikeItem.self, forPrimaryKey: id)!
    }
    
    // 찜한 상품 삭제하기
    func deleteLikeItem(_ item: LikeItem) {
        do {
            try realm.write {
                realm.delete(item)
                print("찜한 상품 삭제 성공")
            }
        } catch {
            print(#function, "찜한 상품 삭제 실패", error)
        }
    }
}
