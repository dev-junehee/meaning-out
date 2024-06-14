//
//  Utils.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import Foundation

/**
 텍스트 필드 입력값 유효성 검사
 조건: @, #, $, % 특수문자 불가, 숫자 불가
 */
func getValidationResult(_ nickname: String) -> Array<Any> {
    let specialChars = ["@", "#", "$", "%"]
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var hasSpecialChar = false
    var hasNumber = false
    
    for char in specialChars {
        for num in numbers {
            if nickname.contains(char) {
                hasSpecialChar = true
            }
            if nickname.contains(num) {
                hasNumber = true
            }
        }
    }
    
    if nickname.isEmpty {
        return [false, "닉네임을 입력해 주세요."]
    } else if hasSpecialChar {
        return [false, "닉네임에 @, #, $, %할 포함될 수 없어요."]
    } else if hasNumber {
        return [false, "닉네임에 숫자는 포함할 수 없어요."]
    } else if nickname.count < 2 || nickname.count >= 10 {
        return [false, "2글자 이상 10글자 미만으로 설정해 주세요."]
    } else {
        return [true, "사용할 수 있는 닉네임이에요."]
    }
}
