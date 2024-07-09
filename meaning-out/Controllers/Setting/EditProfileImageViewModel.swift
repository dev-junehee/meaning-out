//
//  EditProfileImageViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/9/24.
//

import Foundation

class EditProfileImageViewModel {
    
    // 프로필 이미지 변경
    var inputProfileNum: Observable<Int?> = Observable(0)
    var outputProfileNum: Observable<Int> = Observable(0)
    
    init() {
        inputProfileNum.bind { _ in
            self.changeProfileNum()
        }
    }
    
    private func changeProfileNum() {
        guard let profileNum = inputProfileNum.value else { return }
        UserDefaultsManager.profile = profileNum
        outputProfileNum.value = UserDefaultsManager.profile
    }
    
}
