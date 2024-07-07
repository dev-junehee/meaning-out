//
//  UserDefaultsManager.swift
//  meaning-out
//
//  Created by junehee on 6/15/24.
//

import Foundation

enum UserDefaultsKey: String {
    case nickname
    case profile
    case joinDate
    case like
    case search
    case isUser
}

struct UserDefaultsManager {
    @UserDefaultsWrapper (key: .nickname, defaultValue: "손님")
    static var nickname: String
    
    @UserDefaultsWrapper (key: .profile, defaultValue: Int.random(in: 0...11))
    static var profile: Int
    
    @UserDefaultsWrapper (key: .joinDate, defaultValue: "0000. 00. 00")
    static var joinDate: String
    
    @UserDefaultsWrapper (key: .like, defaultValue: [])
    static var like: [String]
    
    @UserDefaultsWrapper (key: .search, defaultValue: [])
    static var search: [String]
    
    @UserDefaultsWrapper (key: .isUser, defaultValue: false)
    static var isUser: Bool
    
    static func getSearchMainTitle() -> String {
        return "\(UserDefaultsManager.nickname)'s MEANING OUT"
    }
    
    static func getJoinDateLabel() -> String {
        return "\(UserDefaultsManager.joinDate) 가입"
    }
    
    static func getLikeLabel() -> String {
        return "\(String(UserDefaultsManager.like.count))개"
    }
    
    static func deleteAllUserDefaults() {
        _nickname.delete()
        _profile.delete()
        _joinDate.delete()
        _like.delete()
        _isUser.delete()
    }
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: UserDefaultsKey
    let defaultValue: T
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
