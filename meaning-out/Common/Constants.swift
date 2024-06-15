//
//  Constants.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import Foundation

/**
 
 Constants: 프로젝트에서 상수로 활용될 문자열, 숫자 데이터
 
 Title: 프로젝트 대표 타이틀, NavigationController 타이틀
 Tab: 메인 화면 탭 타이틀
 Button: 버튼에 사용하는 텍스트
 Alert: 알럿 사용하는 텍스트
 Placeholder: 텍스트필드, 서치바 등 플레이스홀더
 Integer: 프로젝트에서 사용하는 상수 Int 데이터
 
 */

enum Constants {
    enum Title: String {
        case main = "MeaningOut"
        case profile = "PROFILE SETTING"
        case setting = "SETTING"
        case edit = "EDIT PROFILE"
    }
    
    enum Tab: String {
        case search = "검색"
        case setting = "설정"
    }
    
    enum Button: String {
        case start = "시작하기"
        case done = "완료"
        case save = "저장"
        case okay = "확인"
        case cancel = "취소"
    }
    
    enum Alert {
        enum Cancelation: String {
            case title = "탈퇴하기"
            case message = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴하시겠습니까?"
        }
    }
    
    enum Placeholder: String {
        case nickname = "닉네임 NICKNAME"
    }
    
    enum UserDefaults: String {
        case nickname = "nickname"
        case profile = "profileImageNumber"
        case joinDate = "joinDate"
        case cart = "cart"
    }
    
    enum Integer: Int {
        case buttonRadius = 25
        case borderWidth = 3
        case borderWidthEnabled = 1
    }
}
