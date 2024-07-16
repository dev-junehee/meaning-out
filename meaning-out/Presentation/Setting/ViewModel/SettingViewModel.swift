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
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { _ in
            self.outputNickname.value = UserDefaultsManager.nickname
        }
    }
    
}
