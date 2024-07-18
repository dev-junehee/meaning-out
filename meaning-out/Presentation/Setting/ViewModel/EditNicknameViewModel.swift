//
//  EditNicknameViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/9/24.
//

import Foundation

final class EditNicknameViewModel {
    
    // 닉네임 변경
    var inputNickname: Observable<String?> = Observable("")
    var outputIsValid = Observable(false)
    var outputInvalidMessage = Observable("")
    
    // 닉네임 저장
    typealias AlertText = Observable<(isValid: Bool, title: String, message: String)>
    var inputOriginNickname: Observable<String> = Observable("")
    var inputSaveButtonClicked: Observable<Void?> = Observable(nil)
    var outputAlertText: AlertText = Observable((isValid: false, title: "", message: ""))
    
    
    init() {
        inputNickname.bind { _ in
            self.nicknameValidation()
        }
        
        inputSaveButtonClicked.bind { [weak self] _ in
            self?.changeNickname()
        }
    }
    
    // 닉네임 유효성 검사
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
    
    // 수정된 닉네임 저장
    private func changeNickname() {
        guard let newNickname = inputNickname.value else { return }

        // UserDefaults에 저장된 값과 nicknameField 값이 같을 경우
        if inputOriginNickname.value == newNickname {
            outputAlertText.value = (
                isValid: false,
                title: Constants.Alert.SameNickname.title.rawValue,
                message: Constants.Alert.SameNickname.message.rawValue
            )
            return
        }
        
        // 유효성 결과 미통과일 경우
        if !outputIsValid.value {
            outputAlertText.value = (
                isValid: false,
                title: Constants.Alert.FailValidation.title.rawValue,
                message: outputInvalidMessage.value
            )
            return
        }
        
        // 유효성 검사 통과한 경우
        // 입력값 닉네임에 저장 - UserDefaults에 자동 저장
        UserDefaultsManager.nickname = newNickname
        // 저장 완료되면 이전 화면으로 전환
        outputAlertText.value = (
            isValid: true,
            title: Constants.Alert.EditNickname.title.rawValue,
            message: Constants.Alert.EditNickname.message.rawValue
        )
    }
    
}
