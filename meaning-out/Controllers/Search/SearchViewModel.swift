//
//  SearchViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/11/24.
//

import Foundation

final class SearchViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    // 검색어 단일 삭제/전체 삭제
    var inputRemoveSearchList: Observable<Int?> = Observable(nil)
    var inputRemoveAllSearchList: Observable<Void?> = Observable(nil)
    
    var outputNavigationTitle: Observable<String> = Observable("")
    var outputSearchList: Observable<[String]> = Observable([])
    
    // 검색
    var inputSearchButtonClicked: Observable<String?> = Observable(nil)
    var outputSearchIsValid: Observable<Bool> = Observable(false)
    
    // 검색 리스트 클릭
    var inputSearchListClicked: Observable<Int?> = Observable(nil)
    var outputSearchListClicked: Observable<String?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        // viewDidLoad 시점에 UD에 저장된 상품 검색어 리스트 가져오기
        inputViewDidLoadTrigger.bind { _ in
            self.outputSearchList.value = UserDefaultsManager.search
        }
        
        // viewWillAppear 시점마다 상단 네비게이션 타이틀 리로드 (닉네임 변경 관련)
        inputViewWillAppearTrigger.bind { _ in
            self.outputNavigationTitle.value = UserDefaultsManager.getSearchMainTitle()
        }
        
        // 단일 검색어 삭제 버튼
        inputRemoveSearchList.bind { tag in
            guard let tag else { return }
            UserDefaultsManager.search.remove(at: tag)
            self.outputSearchList.value = UserDefaultsManager.search
        }
        
        // 전체 검색어 삭제 버튼
        inputRemoveAllSearchList.bind { _ in
            UserDefaultsManager.search.removeAll()
            self.outputSearchList.value = UserDefaultsManager.search
        }
        
        // 상품 검색
        inputSearchButtonClicked.bind { searchText in
            guard let searchText = searchText else { return }
            
            // 공백값 예외처리
            if searchText.trimmingCharacters(in: [" "]).count == 0 {
                self.outputSearchIsValid.value = false
            } else {
                UserDefaultsManager.search.insert(searchText, at: 0)
                self.outputSearchList.value = UserDefaultsManager.search
                self.outputSearchIsValid.value = true
            }
        }
        
        // 기존 검색어 리스트 클릭
        inputSearchListClicked.bind { idx in
            guard let idx else { return }
            let searchText = self.outputSearchList.value[idx]
            self.outputSearchListClicked.value = searchText
        }
    }
    
}
