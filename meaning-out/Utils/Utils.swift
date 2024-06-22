//
//  Utils.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

/**
 텍스트 필드 입력값 유효성 검사 ver.1
 조건: @, #, $, % 특수문자 불가, 숫자 불가
 */
//func getValidationResult(_ nickname: String) -> Array<Any> {
//    let specialChars = ["@", "#", "$", "%"]
//    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
//    
//    var hasSpecialChar = false
//    var hasNumber = false
//    
//    for char in specialChars {
//        for num in numbers {
//            if nickname.contains(char) {
//                hasSpecialChar = true
//            }
//            if nickname.contains(num) {
//                hasNumber = true
//            }
//        }
//    }
//    
//    if nickname.isEmpty {
//        return [false, "닉네임을 입력해 주세요."]
//    } else if hasSpecialChar {
//        return [false, "닉네임에 @, #, $, %할 포함될 수 없어요."]
//    } else if hasNumber {
//        return [false, "닉네임에 숫자는 포함할 수 없어요."]
//    } else if nickname.count < 2 || nickname.count >= 10 {
//        return [false, "2글자 이상 10글자 미만으로 설정해 주세요."]
//    } else {
//        return [true, "사용할 수 있는 닉네임이에요."]
//    }
//}


/**
 텍스트 입력값 유효성 검사 ver.2
 throw Error
 */
enum ValidationError: Error {
    case empty
    case hasSpecialChar
    case hasNumber
    case invalidLength
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
    
    if nickname.isEmpty {
        throw ValidationError.empty
    } else if hasSpecialChar {
        throw ValidationError.hasSpecialChar
    } else if hasNumber {
        throw ValidationError.hasNumber
    } else if nickname.count < 2 || nickname.count >= 10 {
        throw ValidationError.invalidLength
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
 검색 결과 화면 버튼 UI
 */
func setClickedButtonUI(_ button: UIButton) {
    button.backgroundColor = Resource.Colors.darkGray
    button.setTitleColor(Resource.Colors.white, for: .normal)
    button.layer.borderWidth = 0
}

func setUnclickedButtonUI(_ buttons: [UIButton]) {
    buttons.forEach {
        $0.backgroundColor = Resource.Colors.white
        $0.setTitleColor(Resource.Colors.black, for: .normal)
        $0.layer.borderWidth = 1
    }
}


/**
 상품명에서 <b>, </b> 삭제한 문자열 반환
 */
func getItemTitle(_ itemTitle: String) -> String {
    return itemTitle
        .replacingOccurrences(of: "<b>", with: "")
        .replacingOccurrences(of: "</b>", with: "")
}
