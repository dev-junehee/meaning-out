//
//  LikeCategoryViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/12/24.
//

import Foundation

final class LikeCategoryViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var outputAllLikeCategory: Observable<[LikeCategory]> = Observable([])
    
    var inputAddLikeCategoryButtonClicked: Observable<String?> = Observable(nil)
    var outputAddLikeCetagoryButton: Observable<Void?> = Observable(nil)
    
    var inputDeleteLikeCategory: Observable<Int?> = Observable(nil)
    var outputDeleteLikeCategoryIsSucceed: Observable<Void?> = Observable(nil)
    var outputDeleteLikeCategoryAlert: Observable<(title: String, message: String, category: LikeCategory?)> = Observable((title: "", message: "", category: nil))
    
    var inputDeleteLikeCategoryAlertOkay: Observable<LikeCategory?> = Observable(nil)
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            self.outputAllLikeCategory.value = self.repository.getAllLikeCategory()
        }
        
        inputAddLikeCategoryButtonClicked.bind { textFieldText in
            guard let textFieldText = textFieldText else { return }
            let likeCategory = LikeCategory(name: textFieldText)
            self.repository.createLikeCategory(likeCategory)
            self.outputAllLikeCategory.value = self.repository.getAllLikeCategory()
            self.outputAddLikeCetagoryButton.value = ()
        }
        
        // 밀어서 삭제하기 클릭
        inputDeleteLikeCategory.bind { idx in
            guard let idx = idx else { return }
            let category = self.outputAllLikeCategory.value[idx]
            
            if category.detailData.isEmpty {
                self.repository.deleteLikeCategory(category)
                self.outputAllLikeCategory.value = self.repository.getAllLikeCategory()
                self.outputDeleteLikeCategoryIsSucceed.value = ()
            } else {
                self.outputDeleteLikeCategoryAlert.value = (
                    title: Constants.Alert.DeleteLikeCategory.title.rawValue,
                    message: Constants.Alert.DeleteLikeCategory.message.rawValue,
                    category: category)
            }
        }
        
        // 찜 상품이 있는 카테고리 삭제 시 Alert 확인 버튼 클릭
        inputDeleteLikeCategoryAlertOkay.bind { category in
            guard let category else { return }
            self.repository.deleteLikeCategory(category)
            self.outputAllLikeCategory.value = self.repository.getAllLikeCategory()
            self.outputDeleteLikeCategoryIsSucceed.value = ()
        }
    }
    
}
