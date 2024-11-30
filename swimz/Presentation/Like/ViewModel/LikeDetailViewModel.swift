//
//  LikeDetailViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/13/24.
//

import Foundation

final class LikeDetailViewModel {
    
    var inputViewAppearTrigger: Observable<Int?> = Observable(nil)
    var outputCategoryDataIsEmpty: Observable<Bool> = Observable(false)
    
    var inputDeleteLikeItem: Observable<(title: String?, tag: Int?)> = Observable((title: "", tag: 0))
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewAppearTrigger.bind { [weak self] count in
            guard let count else { return }
            if count == 0 {
                self?.outputCategoryDataIsEmpty.value = true
            } else {
                self?.outputCategoryDataIsEmpty.value = false
            }
        }
        
        inputDeleteLikeItem.bind { [weak self] title, tag in
            guard let tag else { return }
            
            if let category = self?.repository.findLikeCategory(title: title ?? "") {
                self?.repository.deleteLikeItemInCategory(item: category.detailData[tag], category: category, at: tag)
                if category.detailData.isEmpty {
                    self?.outputCategoryDataIsEmpty.value = true
                } else {
                    self?.outputCategoryDataIsEmpty.value = false
                }
            }
        }
        
    }
    
}
