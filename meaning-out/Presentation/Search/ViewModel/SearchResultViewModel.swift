//
//  SearchResultViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/12/24.
//

import Foundation

enum ShoppingResponse {
    case success
    case noResult
    case fail
}

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
    var outputShoppingResponse: Observable<ShoppingResponse> = Observable(.fail)
    var outputShoppingResult: Observable<(total: Int, items: [Shopping])> = Observable((total: 0, items:[]))
    
    // 찜 카테고리, 찜 상품
    var outputLikeItemIsValid: Observable<(isValid: Bool, categoryList: [LikeCategory]?, likeItem: LikeItem?)> = Observable((isValid: false, categoryList: [], likeItem: nil))
    
    // 찜 저장/삭제 처리 결과
    var outputSaveDeleteLikeItemIsSucceed: Observable<Bool> = Observable(false)
    
    // 상품 상세 화면 전환
    var outputTransitionToDetail: Observable<Shopping?> = Observable(nil)
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        transform()
    }
 
    private func transform() {
        inputCallRequest.bind { [weak self] query, start, sort in
            self?.callRequest(query: query, start: start, sort: sort)
        }
        
        inputSearchItemClicked.bind { [weak self] idx in
            guard let idx else { return }
            let item = self?.outputShoppingResult.value.items[idx]
            self?.outputTransitionToDetail.value = item
        }
        
        inputSearchItemLikeButtonClicked.bind { [weak self] tag in
            guard let tag else { return }
            let item = self?.outputShoppingResult.value.items[tag]
            self?.likeButtonClicked(item: item)
        }
        
        inputSelectedLikeCategory.bind { [weak self] selected, likeItem in
            guard let selected else { return }
            if let category = self?.repository.findLikeCategory(title: selected) {
                guard let likeItem else { return }
                self?.repository.createLikeItem(likeItem, category: category)
                self?.outputSaveDeleteLikeItemIsSucceed.value = true
            }
        }
        
        inputDeleteLikeItem.bind { [weak self] likeItem in
            guard let likeItem  else { return }
            self?.repository.deleteLikeItem(item: likeItem)
            self?.outputSaveDeleteLikeItemIsSucceed.value = true
        }
    }
    
    private func callRequest(query: String, start: Int, sort: SortType) {
        NetworkManager.shared.getShopping(query: query, start: start, sort: sort.rawValue) { res in
            switch res {
            case .success(let data):
                if data.total == 0 {
                    self.outputShoppingResponse.value = .noResult
                    return
                }
    
                if start == 1 {
                    self.outputShoppingResult.value.items.removeAll()
                    self.outputShoppingResult.value = (total: data.total, items: data.items)
                    self.outputShoppingResponse.value = .success
                } else {
                    self.outputShoppingResult.value.total = data.total
                    self.outputShoppingResult.value.items.append(contentsOf: data.items)
                    self.outputShoppingResponse.value = .success
                }
            case .failure(let _):
                self.outputShoppingResponse.value = .fail
            }
        }
    }
    
    private func likeButtonClicked(item: Shopping?) {
        // if - 저장된 상품이 없으면 저장 액션시트 보여주기
        // else - 이미 저장된 상품
        guard let item else { return }
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
