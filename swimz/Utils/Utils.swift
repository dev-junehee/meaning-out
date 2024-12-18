//
//  Utils.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

/**
 텍스트 입력값 유효성 검사
 throw Error
 */
enum ValidationError: Error {
    case empty
    case hasSpecialChar
    case hasNumber
    case invalidLength
    case same
}

func getValidationResult(_ nickname: String) throws -> Bool {
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
    
    if nickname.isEmpty || nickname.trimmingCharacters(in: .whitespaces).isEmpty {
        throw ValidationError.empty
    } else if hasSpecialChar {
        throw ValidationError.hasSpecialChar
    } else if hasNumber {
        throw ValidationError.hasNumber
    } else if nickname.count < 2 || nickname.count >= 10 {
        throw ValidationError.invalidLength
    } else if nickname == UserDefaultsManager.nickname {
        throw ValidationError.same
    } else {
        return true
    }
}


/**
 오늘 날짜를 원하는 포맷 형식으로 변환
 */
func getTodayString(formatType: String) -> String {
    let today = Date()
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    dateFormatter.dateFormat = formatType
    
    let convertedToday = dateFormatter.string(from: today)
    
    return convertedToday
}


/**
 상품명에서 <b>, </b> 삭제한 문자열 반환
 */
func getItemTitle(_ itemTitle: String) -> String {
    return itemTitle
        .replacingOccurrences(of: "<b>", with: "")
        .replacingOccurrences(of: "</b>", with: "")
}
