//
//  LikeItemRepository.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import Foundation
import RealmSwift

final class LikeItemRepository {
    
    private let realm = try! Realm()
    
    // 스키마 버전 확인
    func getSchemaVersion() {
        print(realm.configuration.schemaVersion)
    }
    
    // 저장 루트 확인하기
    func getFileURL() {
        print(realm.configuration.fileURL)
    }
    
    // 좋아요 상품 저장하기
    func saveLikeItem(_ item: LikeItemTable) {
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
    func getAllLikeItem() -> Results<LikeItemTable> {
        return realm.objects(LikeItemTable.self)
    }
    
    // 찜한 상품 찾기
    func findLikeItem(id: String) -> LikeItemTable {
        return realm.object(ofType: LikeItemTable.self, forPrimaryKey: id)!
    }
    
    // 찜한 상품 삭제하기
    func deleteLikeItem(_ item: LikeItemTable) {
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
