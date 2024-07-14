//
//  SearchResultViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/12/24.
//

import Foundation

final class SearchResultViewModel {
    
    // API 호출
    var inputCallRequest: Observable<(query: String, start: Int, sort: SortType)> = Observable((query: "", start: 1, sort: .sim))
    
    // 검색 상품 클릭, 찜 버튼 클릭
    var inputSearchItemClicked: Observable<Int?> = Observable(nil)
    var inputSearchItemLikeButtonClicked: Observable<Int?> = Observable(nil)
    
    // 찜 카테고리 클릭
    var inputSelectedLikeCategory: Observable<(category: String?, likeItem: LikeItem?)> = Observable((category: nil, likeItem: nil))
    var inputDeleteLikeItem: Observable<LikeItem?> = Observable(nil)
    
    // API 호출 결과
    var outputShoppingResultIsValid: Observable<Bool> = Observable(false)
    var outputShoppingResult: Observable<(total: Int, items: [Shopping])> = Observable((total: 0, items:[]))
    
    // 찜 카테고리, 찜 상품
    var outputLikeItemIsValid: Observable<(isValid: Bool, categoryList: [LikeCategory]?, likeItem: LikeItem?)> = Observable((isValid: false, categoryList: [], likeItem: nil))
    var outputSaveLikeItemIsSucceed: Observable<Bool> = Observable(false)
    var outputDeleteLikeItemIsSucceed: Observable<Bool> = Observable(false)
    var outputTransitionToDetail: Observable<Shopping?> = Observable(nil)
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        transform()
    }
 
    private func transform() {
        inputCallRequest.bind { query, start, sort in
            self.callRequest(query: query, start: start, sort: sort)
        }
        
        inputSearchItemClicked.bind { idx in
            guard let idx else { return }
            let item = self.outputShoppingResult.value.items[idx]
            self.outputTransitionToDetail.value = item
        }
        
        inputSearchItemLikeButtonClicked.bind { tag in
            guard let tag else { return }
            let item = self.outputShoppingResult.value.items[tag]
            self.likeButtonClicked(item: item)
        }
        
        inputSelectedLikeCategory.bind { selected, likeItem in
            guard let selected else { return }
            if let category = self.repository.findLikeCategory(title: selected) {
                guard let likeItem else { return }
                self.repository.createLikeItem(likeItem, category: category)
                self.outputSaveLikeItemIsSucceed.value = true
            }
        }
        
        inputDeleteLikeItem.bind { likeItem in
            guard let likeItem  else { return }
            self.repository.deleteLikeItem(item: likeItem)
            self.outputDeleteLikeItemIsSucceed.value = true
        }
    }
    
    private func callRequest(query: String, start: Int, sort: SortType) {
        NetworkManager.shared.getShopping(query: query, start: start, sort: sort.rawValue) { res in
            if res.total == 0 {
                self.outputShoppingResultIsValid.value = false
                return
            }
            
            if start == 1 {
                self.outputShoppingResult.value.items.removeAll()
                self.outputShoppingResult.value = (total: res.total, items: res.items)
                self.outputShoppingResultIsValid.value = true
            } else {
                self.outputShoppingResult.value.total = res.total
                self.outputShoppingResult.value.items.append(contentsOf: res.items)
                self.outputShoppingResultIsValid.value = true
            }
        }
    }
    
    private func likeButtonClicked(item: Shopping) {
        // if - 저장된 상품이 없으면 저장 액션시트 보여주기
        // else - 이미 저장된 상품
        if !repository.isLikeItem(id: item.productId) {
            self.outputLikeItemIsValid.value = (
                isValid: false,
                categoryList: repository.getAllLikeCategory(),
                likeItem: LikeItem(item: item)
            )
        } else {
            self.outputLikeItemIsValid.value = (
                isValid: true,
                categoryList: nil,
                likeItem: repository.findLikeItem(id: item.productId)
            )
        }
    }
    
}
