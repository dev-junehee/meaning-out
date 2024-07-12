//
//  SearchResultViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/12/24.
//

import Foundation

final class SearchResultViewModel {
    
    // 화면 전환됐을 때 네트워크 요청
    var inputCallRequest: Observable<(query: String, start: Int, sort: SortType)> = Observable((query: "", start: 1, sort: .sim))
    
    var inputRefetchingPagenation: Observable<(query: String, start: Int, sort: SortType)> = Observable((query: "", start: 1, sort: .sim))
    
    var outputShoppingResultIsValid: Observable<Bool> = Observable(false)
    var outputNoResultAlert: Observable<(title: String, message: String)> = Observable((title: "", message: ""))
    var outputShoppingTotal: Observable<Int> = Observable(0)
    var outputShoppingResult: Observable<[Shopping]> = Observable([])
    
    
    init() {
        transform()
    }
 
    private func transform() {
        inputCallRequest.bind { query, start, sort in
            print(start)
            self.callRequest(query: query, start: start, sort: sort)
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
    
}
