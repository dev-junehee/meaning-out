//
//  SettingViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/13/24.
//

import Foundation

final class SettingViewModel {
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var outputNickname: Observable<String> = Observable("")
    
    // 탈퇴하기 Alert 확인 버튼 클릭
    var inputCancelationAlert: Observable<Void?> = Observable(nil)
    var outputCancelationIsSucceed: Observable<Void?> = Observable(nil)
    
    private let repository = RealmLikeItemRepository()
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { _ in
            self.outputNickname.value = UserDefaultsManager.nickname
        }
        
        inputCancelationAlert.bind { [weak self] _ in
            self?.repository.deleteAll()
            UserDefaultsManager.deleteAllUserDefaults()
            self?.outputCancelationIsSucceed.value = ()
        }
    }
    
}
