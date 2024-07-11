//
//  SearchViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/11/24.
//

import Foundation

final class SearchViewModel {
    
    var inputViewWillAppear: Observable<Void?> = Observable(nil)
    var outputNavigationTitle: Observable<String> = Observable("")
    
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppear.bind { _ in
            self.outputNavigationTitle.value = UserDefaultsManager.getSearchMainTitle()
        }
        
    }
    
    
}
