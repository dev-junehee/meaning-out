//
//  ProfileNicknameViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/10/24.
//

import Foundation

final class ProfileNicknameViewModel {
    
    // 트리거
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var outputProfileNum: Observable<Int> = Observable(UserDefaultsManager.profile)
    
    // 닉네임
    var inputNickname: Observable<String?> = Observable("")
    var outputIsValid = Observable(false)
    var outputInvalidMessage = Observable("")
    
    // 프로필 사진
    var inputProfileTapped: Observable<Void?> = Observable(nil)
    var transitionProfileImage: (() -> Void)?
    
    // 완료버튼
    var inputDoneButtonClicked: Observable<Void?> = Observable(nil)
    var outputSaveUserAccountResult = Observable(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            UserDefaultsManager.profile = Int.random(in: 0..<Resource.Images.profiles.count)
            self?.outputProfileNum.value = UserDefaultsManager.profile
        }
        
        inputViewWillAppearTrigger.bind { [weak self] _ in
            self?.outputProfileNum.value = UserDefaultsManager.profile
        }
        
        inputNickname.bind { [weak self] _ in
            self?.nicknameValidation()
        }
        
        inputProfileTapped.bind { [weak self] _ in
            self?.transitionProfileImage?()
        }
        
        inputDoneButtonClicked.bind { [weak self] _ in
            self?.saveUserAccount()
        }
    }
    
    
    private func nicknameValidation() {
        guard let nickname = inputNickname.value else { return }

        do {
            let result = try getValidationResult(nickname)
            if result {
                outputIsValid.value = true
                outputInvalidMessage.value = Constants.Validation.Nickname.success.rawValue
            }
        } catch ValidationError.empty {
            outputIsValid.value = false
            outputInvalidMessage.value = Constants.Validation.Nickname.empty.rawValue
        } catch ValidationError.hasSpecialChar{
            outputIsValid.value = false
            outputInvalidMessage.value = Constants.Validation.Nickname.hasSpecialChar.rawValue
        } catch ValidationError.hasNumber {
            outputIsValid.value = false
            outputInvalidMessage.value = Constants.Validation.Nickname.hasNumber.rawValue
        } catch ValidationError.invalidLength {
            outputIsValid.value = false
            outputInvalidMessage.value = Constants.Validation.Nickname.invalidLength.rawValue
        } catch ValidationError.same {
            outputIsValid.value = false
            outputInvalidMessage.value = Constants.Validation.Nickname.same.rawValue
        } catch {
            outputIsValid.value = false
            outputInvalidMessage.value = Constants.Validation.Nickname.etc.rawValue
        }
    }
    
    private func saveUserAccount() {
        // 유효성 검사 통과 시 프로필 사진/닉네임 저장
        guard let nickname = inputNickname.value else { return }
        UserDefaultsManager.nickname = nickname
        UserDefaultsManager.profile = outputProfileNum.value
        UserDefaultsManager.joinDate = getTodayString(formatType: "yyyy. MM. dd")
        UserDefaultsManager.like = []
        UserDefaultsManager.search = []
        UserDefaultsManager.isUser = true
        
        outputSaveUserAccountResult.value = true
    }
    
}
