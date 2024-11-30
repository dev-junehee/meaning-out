//
//  UITabBarController+Extension.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

extension UITabBarController {
    func setTabBarUI() {
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        self.tabBar.backgroundColor = Resource.Colors.lightGray
    }
}

