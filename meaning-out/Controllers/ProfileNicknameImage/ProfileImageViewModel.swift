//
//  ProfileImageViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/10/24.
//

import Foundation

final class ProfileImageViewModel {
    
    var inputViewWillAppear: Observable<Void?> = Observable(nil)
    var outputProfileNum: Observable<Int> = Observable(0)
    
    var inputImageSelected: Observable<Int?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppear.bind { _ in
            self.outputProfileNum.value = UserDefaultsManager.profile
        }
        
        inputImageSelected.bind { num in
            guard let num = num else { return }
            UserDefaultsManager.profile = num
            self.outputProfileNum.value = UserDefaultsManager.profile
        }
    }
    
}
