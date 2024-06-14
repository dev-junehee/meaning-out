//
//  User.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

struct User {
    var nickname: String = UserDefaults.standard.string(forKey: Constants.Text.UserDefaults.nickname.rawValue) ?? "손님"
    var profile: Int = UserDefaults.standard.integer(forKey: Constants.Text.UserDefaults.profile.rawValue)
    let joinDate: String = UserDefaults.standard.string(forKey: Constants.Text.UserDefaults.joinDate.rawValue) ?? "가입 날짜 없음"
    var cart: Int = UserDefaults.standard.integer(forKey: Constants.Text.UserDefaults.cart
        .rawValue)
}