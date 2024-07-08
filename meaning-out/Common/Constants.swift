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
        case meaningout = "MeaningOut"
        case profile = "PROFILE SETTING"
        case likeCategory = "찜 카테고리"
        case setting = "SETTING"
        case edit = "EDIT PROFILE"
    }
    
    enum Tab: String {
        case search = "검색"
        case like = "찜"
        case setting = "설정"
    }
    
    enum Button: String, CaseIterable {
        case start = "시작하기"
        case done = "완료"
        case save = "저장"
        case okay = "확인"
        case cancel = "취소"
        
        static var sorting: [String] {
            return ["정확도", "날짜순", "가격높은순", "가격낮은순"]
        }
    }
    
    enum Alert {
        enum SameNickname: String {
            case title = "새로운 닉네임을 입력해 주세요!"
            case message = "이미 사용 중인 닉네임이에요."
        }
        
        enum FailValidation: String {
            case title = "유효한 닉네임을 입력해 주세요!"
        }
        
        enum EditNickname: String {
            case title = "닉네임 수정 완료!"
            case message = "닉네임이 성공적으로 수정되었어요.\n이전 화면으로 돌아갈게요."
        }
        
        enum Cancelation: String {
            case title = "탈퇴하기"
            case message = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴하시겠습니까?"
        }
        
        enum EmptyString: String {
            case title = "공백이에요!"
            case message = "올바른 검색어를 입력해 주세요."
        }
        
        enum FailSearch: String {
            case title = "검색 실패😭"
            case message = "검색 결과에 오류가 생겼어요."
        }
        
        enum createLikeCategory: String {
            case title = "찜 카테고리 생성"
            case message = "찜 카테고리명을 작성해 주세요!"
        }
        
        enum selectLikeCategory: String {
            case title = "찜 상품을 저장할 카테고리를 선택해 주세요!"
        }
    }
    
    enum Validation {
        enum Nickname: String {
            case success = "사용할 수 있는 닉네임이에요."
            case empty = "닉네임을 입력해 주세요."
            case hasSpecialChar = "닉네임에 @, #, $, %할 포함될 수 없어요."
            case hasNumber = "닉네임에 숫자는 포함할 수 없어요."
            case invalidLength = "2글자 이상 10글자 미만으로 설정해 주세요."
            case etc = "알 수 없는 오류에요🥲"
        }
    }
    
    enum Search: String {
        case empty = "최근 검색어가 없어요"
        case recent = "최근 검색"
        case remove = "전체 삭제"
        case sortSim = "sim"
        case sortDate = "date"
        case sortDsc = "dsc"
        case sortAsc = "asc"
    }
    
    enum Like: String {
        case empty = "찜 카테고리가 없어요"
    }
    
    enum SettingOptions: String, CaseIterable {
        case profile
        case menu
        
        var menuOptions: [String] {
            return ["내가 찜한 상품", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
        }
        
        static let like = "의 상품"
    }
    
    enum Placeholder: String {
        case nickname = "닉네임 NICKNAME"
        case searchBar = "브랜드, 상품 등을 입력하세요."
    }
    
    enum Integer: Int {
        case buttonRadius = 20
        case borderWidth = 3
        case borderWidthEnabled = 1
    }
}
