//
//  Colors.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

/**
 Colors: 프로젝트에서 사용될 색상
 Fonts: 프로젝트에서 사용되는 폰트
 */

enum Resource {
    enum Colors {
        static let primary: UIColor = .init(rgb: 0xef8947)
        static let black: UIColor = .init(rgb: 0x000000)
        static let darkGray: UIColor = .init(rgb: 0x4c4c4c)
        static let gray: UIColor = .init(rgb: 0x828282)
        static let lightGray: UIColor = .init(rgb: 0xcdcdcd)
        static let white: UIColor = .init(rgb: 0xffffff)
    }
    
    enum Fonts {
        static let mainTitle: UIFont = .systemFont(ofSize: 42, weight: .black)
        static let button: UIFont = .systemFont(ofSize: 16, weight: .black)
        static let bold16: UIFont = .systemFont(ofSize: 16, weight: .bold)
        static let bold15: UIFont = .systemFont(ofSize: 15, weight: .bold)
        static let bold14: UIFont = .systemFont(ofSize: 14, weight: .bold)
        static let bold13: UIFont = .systemFont(ofSize: 13, weight: .bold)
        static let semiBold16: UIFont = .systemFont(ofSize: 16, weight: .semibold)
        static let semiBold15: UIFont = .systemFont(ofSize: 15, weight: .semibold)
        static let semiBold14: UIFont = .systemFont(ofSize: 14, weight: .semibold)
        static let semiBold13: UIFont = .systemFont(ofSize: 13, weight: .semibold)
        static let regular16: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let regular15: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let regular14: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let regular13: UIFont = .systemFont(ofSize: 13, weight: .regular)
    }
    
    enum Images {
        static let profiles: [UIImage] = [
            .profile0, .profile1, .profile2, .profile3, .profile4, .profile5,
            .profile6, .profile7, .profile8, .profile9, .profile10, .profile11
        ]
        
        static let launch: UIImage = .launch
    }
    
    enum SystemImages {
        static let search = UIImage(systemName: "magnifyingglass")!
        static let clock = UIImage(systemName: "clock")!
        static let person = UIImage(systemName: "person")!
        static let exit = UIImage(systemName: "xmark")!
        static let left = UIImage(systemName: "chevron.left")!
        static let right = UIImage(systemName: "chevron.right")!
        static let camara = UIImage(systemName: "camera.fill")!
        static let cart = UIImage(systemName: "handbag.fill")
    }
}
