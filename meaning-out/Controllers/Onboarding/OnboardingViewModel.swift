//
//  OnboardingViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/14/24.
//

import Foundation

final class OnboardingViewModel {
    
    var inputStartButtonClicked: Observable<Void?> = Observable(nil)
    var transitionToProfileNickname: (() -> Void)?
    
    init() {
        inputStartButtonClicked.bind { _ in
            self.transitionToProfileNickname?()
        }
    }
    
}
