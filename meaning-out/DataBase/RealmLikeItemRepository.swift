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
    
    // 찜 카테고리 만들기
    func createLikeCategory(_ category: LikeCategory) {
        do {
            try realm.write {
                realm.add(category)
                print("카테고리 생성 성공")
            }
        } catch {
            print("카테고리 생성 실패")
        }
    }
    
    // 찜 카테고리 가져오기
    func getAllLikeCategory() -> [LikeCategory] {
        let category = realm.objects(LikeCategory.self)
        return Array(category)
    }
    
    // 찜 카테고리 찾기
    func findLikeCategory(title: String) -> LikeCategory? {
        return realm.objects(LikeCategory.self).where {
            $0.title == title
        }.first
    }
    
    
    // 찜 카테고리 지우기
    func deleteLikeCategory(_ category: LikeCategory) {
        do {
            try realm.write {
                realm.delete(category.detailData)
                realm.delete(category)
                print("폴더 삭제 성공")
            }
        } catch {
            print("폴더 삭제 실패", error)
        }
    }
    
    // 찜한 상품 저장하기
    func createLikeItem(_ item: LikeItem, category: LikeCategory) {
        do {
            try realm.write {
                category.detailData.append(item)
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
    
    // 찜한 상품 개수 (문자열) 불러오기
    func getAllLikeItemString() -> String {
        return "\(realm.objects(LikeItem.self).count)개"
    }
    
    
    // 찜한 상품 찾기
    func findLikeItem(id: String) -> LikeItem? {
        return realm.object(ofType: LikeItem.self, forPrimaryKey: id)
    }
    
    // 찜한 상품 여부
    func isLikeItem(id: String) -> Bool {
        if findLikeItem(id: id) != nil {
            return true
        } else {
            return false
        }
    }
    
    // 찜한 상품 삭제하기
    func deleteLikeItem(item: LikeItem) {
        do {
            try realm.write {
                realm.delete(item)
                print("찜한 상품 삭제 성공")
            }
        } catch {
            print("찜한 상품 삭제 실패", error)
        }
    }
    
    // 찜 카테고리 안에 있는 찜한 상품 삭제하기
    func deleteLikeItemInCategory(item: LikeItem, category: LikeCategory, at: Int) {
        do {
            try realm.write {
                category.detailData.remove(at: at)
                realm.delete(item)
                print("찜 카테고리에서 해당 상품 삭제 성공")
            }
        } catch {
            print("찜 카테고리에서 해당 상품 삭제 실패", error)
        }
    }
    
    // 전체 삭제
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
                print("전체 삭제 성공")
            }
        } catch {
            print("전체 삭제 실패", error)
        }
    }
}
