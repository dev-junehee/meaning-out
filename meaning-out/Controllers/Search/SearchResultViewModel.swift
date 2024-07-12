//
//  SearchResultViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/12/24.
//

import Foundation

final class SearchResultViewModel {
    
    var inputCallRequest: Observable<(query: String, start: Int, sort: SortType)> = Observable((query: "", start: 1, sort: .sim))
    var inputSearchItemClicked: Observable<Int?> = Observable(nil)
    var inputSearchItemLikeButtonClicked: Observable<Int?> = Observable(nil)
    var inputSelectedLikeCategory: Observable<String?> = Observable(nil)
    
    var outputShoppingResultIsValid: Observable<Bool> = Observable(false)
    var outputNoResultAlert: Observable<(title: String, message: String)> = Observable((title: "", message: ""))
    var outputShoppingTotal: Observable<Int> = Observable(0)
    var outputShoppingResult: Observable<[Shopping]> = Observable([])
    var outputLikeItemIsValid: Observable<(isValid: Bool, categoryList: [LikeCategory]?)> = Observable((isValid: false, categoryList: []))
    var outputSaveLikeItemIsSucceed: Observable<Bool> = Observable(false)
    
    var outputTransitionToDetail: Observable<Shopping?> = Observable(nil)
    
    
    var likeItem: Observable<LikeItem?> = Observable(nil)
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        transform()
    }
 
    private func transform() {
        inputCallRequest.bind { query, start, sort in
            print(start)
            self.callRequest(query: query, start: start, sort: sort)
        }
        
        inputSearchItemClicked.bind { idx in
            guard let idx else { return }
            let item = self.outputShoppingResult.value[idx]
            self.outputTransitionToDetail.value = item
        }
        
        inputSearchItemLikeButtonClicked.bind { tag in
            guard let tag else { return }
            let item = self.outputShoppingResult.value[tag]
            self.likeButtonClicked(item: item)
        }
        
        inputSelectedLikeCategory.bind { selected in
            guard let selected else { return }
            if let category = self.repository.findLikeCategory(title: selected) {
                self.repository.createLikeItem(self.likeItem.value!, category: category)
                self.outputSaveLikeItemIsSucceed.value = true
            }
        }
    }
    
    private func callRequest(query: String, start: Int, sort: SortType) {
        NetworkManager.shared.getShopping(query: query, start: start, sort: sort.rawValue) { res in
            if res.total == 0 {
                self.outputNoResultAlert.value = (
                    title: Constants.Alert.NoSearchResult.title.rawValue,
                    message: Constants.Alert.NoSearchResult.message.rawValue)
                return
            }
            
            if start == 1 {
                self.outputShoppingResult.value.removeAll()
                self.outputShoppingResult.value = res.items
                self.outputShoppingTotal.value = res.total
                self.outputShoppingResultIsValid.value = true
            } else {
                self.outputShoppingTotal.value = res.total
                self.outputShoppingResult.value.append(contentsOf: res.items)
                self.outputShoppingResultIsValid.value = true
            }
        }
    }
    
    private func likeButtonClicked(item: Shopping) {
        // 저장된 상품이 없으면 저장 액션시트 보여주기
        if !repository.isLikeItem(id: item.productId) {
            self.outputLikeItemIsValid.value = (isValid: false, categoryList: repository.getAllLikeCategory())
            self.likeItem.value = LikeItem(item: item)
            
//            let likeItem = LikeItem(item: item)
//            showCategoryActionSheet(repository.getAllLikeCategory()) { selected in
//                guard let selected else { return print("선택한 카테고리 없음") }
//                if let category = self.repository.findLikeCategory(title: selected) {
//                    self.repository.createLikeItem(likeItem, category: category)
//                    self.mainView.resultCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
//                }
//            }
        } else {
            // 찜했을 때 - 찜 취소
            self.outputLikeItemIsValid.value = (isValid: true, categoryList: nil)
            
//            showAlert(title: "찜을 해제할까요?", message: "해당 상품이 찜에서 사라져요!", type: .twoButton) { _ in
//                let item = self.viewModel.outputShoppingResult.value[sender.tag]
//                let target = self.repository.findLikeItem(id: item.productId)
//                if let target {
//                    self.repository.deleteLikeItem(item: target)
//                    self.mainView.resultCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
//                }
//            }
        }
    }
    
}
