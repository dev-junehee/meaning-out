//
//  SearchResultDetailViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/12/24.
//

import Foundation

final class SearchResultDetailViewModel {
    
    var inputLikeBarButtonClicked: Observable<Shopping?> = Observable(nil)
    var outputLikeBarButtonClicked: Observable<Void?> = Observable(nil)
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        inputLikeBarButtonClicked.bind { item in
            print(#function, item)
        }
    }
    
}
