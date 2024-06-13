//
//  Constants.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import Foundation

/**
 Constants: 프로젝트에서 상수로 활용될 문자열, 숫자 데이터
 */
enum Constants {
    enum Text {
        enum Title: String {
            case main = "MeaningOut"
            case profile = "PROFILE SETTING"
            case setting = "SETTING"
            case edit = "EDIT PROFILE"
        }
        
        enum Button: String {
            case start = "시작하기"
            case done = "완료"
            case save = "저장"
        }
    }
    
    enum Integer: Int {
        case buttonRadius = 25
    }
}
