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
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewAppearTrigger.bind { count in
            guard let count else { return }
            if count == 0 {
                self.outputCategoryDataIsEmpty.value = true
            } else {
                self.outputCategoryDataIsEmpty.value = false
            }
        }
    }
    
}
