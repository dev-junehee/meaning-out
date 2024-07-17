//
//  SearchResultDetailViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/12/24.
//

import Foundation

enum BarButtonClickResult {
    case like
    case unlike
}

final class SearchResultDetailViewModel {
    
    // 화면 다시 나타날 때 찜 여부 확인
    var inputViewWillAppearTrigger: Observable<String?> = Observable(nil)
    
    // 상단 찜 바버튼 클릭
    var inputLikeBarButtonClicked: Observable<Shopping?> = Observable(nil)
    typealias outputLikeBarButtonClicked = (isValid: Bool, categoryList: [LikeCategory]?, likeItem: LikeItem?)
    var outputLikeBarButtonClicked: Observable<outputLikeBarButtonClicked> = Observable((isValid: false, categoryList: nil, likeItem: nil))
    
    // 찜 카테고리 클릭, 찜 해제 Alert - 확인 클릭
    var inputSelectedLikeCategory:  Observable<(category: String?, likeItem: LikeItem?)> = Observable((category: nil, likeItem: nil))
    var inputDeleteLikeItem:  Observable<LikeItem?> = Observable(nil)
    
    // 찜 상품 저장/해제 결과
    var outputLikeItemSaveDeleteReuslt: Observable<BarButtonClickResult> = Observable(.unlike)
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { id in
            guard let id else { return }
            if self.repository.isLikeItem(id: id) {
                self.outputLikeItemSaveDeleteReuslt.value = .like   // 찜 저장한 상태
            } else {
                self.outputLikeItemSaveDeleteReuslt.value = .unlike   // 찜 해제한 상태
            }
        }
        
        inputLikeBarButtonClicked.bind { [weak self] item in
            guard let item else { return }
            self?.likeButtonClicked(item: item)
        }
        
        inputSelectedLikeCategory.bind { [weak self] selected, likeItem in
            guard let selected else { return }
            if let category = self?.repository.findLikeCategory(title: selected) {
                guard let likeItem else { return }
                self?.repository.createLikeItem(likeItem, category: category)
                self?.outputLikeItemSaveDeleteReuslt.value = .like   // 찜 저장한 상태
            }
        }
        
        inputDeleteLikeItem.bind { [weak self] likeItem in
            guard let likeItem  else { return }
            self?.repository.deleteLikeItem(item: likeItem)
            self?.outputLikeItemSaveDeleteReuslt.value = .unlike   // 찜 해제한 상태
        }
        
    }
    
    private func likeButtonClicked(item: Shopping) {
        // if - 저장된 상품이 없으면 저장 액션시트 보여주기
        // else - 이미 저장된 상품
        if !repository.isLikeItem(id: item.productId) {
            self.outputLikeBarButtonClicked.value = (
                isValid: false,
                categoryList: repository.getAllLikeCategory(),
                likeItem: LikeItem(item: item)
            )
        } else {
            self.outputLikeBarButtonClicked.value = (
                isValid: true,
                categoryList: nil,
                likeItem: repository.findLikeItem(id: item.productId)
            )
        }
    }
    
}
