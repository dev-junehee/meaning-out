//
//  EditNicknameViewModel.swift
//  meaning-out
//
//  Created by junehee on 7/9/24.
//

import Foundation

final class EditNicknameViewModel {
    
    var inputNickname: Observable<String?> = Observable("")
    
    var outputIsValid = Observable(false)
    var outputInvalidMessage = Observable("")
    
    init() {
        inputNickname.bind { _ in
            self.nicknameValidaion()
        }
    }
    
    private func nicknameValidaion() {
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
        } catch {
            outputIsValid.value = false
            outputInvalidMessage.value = Constants.Validation.Nickname.etc.rawValue
        }
    }
    
    
}
