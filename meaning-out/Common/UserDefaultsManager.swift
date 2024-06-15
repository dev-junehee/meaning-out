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
    case cart
    case isUser
}

struct UserDefaultsManager {
    @UserDefaultsWrapper (key: .nickname, defaultValue: "손님")
    static var nickname: String
    
    @UserDefaultsWrapper (key: .profile, defaultValue: Int.random(in: 0...11))
    static var profile: Int
    
    @UserDefaultsWrapper (key: .joinDate, defaultValue: "0000. 00. 00")
    static var joinDate: String
    
    @UserDefaultsWrapper (key: .cart, defaultValue: 0)
    static var cart: Int
    
    @UserDefaultsWrapper (key: .isUser, defaultValue: false)
    static var isUser: Bool
    
    static func deleteAllUserDefaults() {
        _nickname.delete()
        _profile.delete()
        _joinDate.delete()
        _cart.delete()
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
