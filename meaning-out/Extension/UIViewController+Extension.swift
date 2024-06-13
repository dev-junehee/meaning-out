//
//  UINavigationController+Extension.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

enum BarButtonType {
    case left
    case right
}

extension UIViewController {
    // BarButton - text
    func addTextBarBtn(title: String?, style: UIBarButtonItem.Style, target: Any?, action: Selector?, type: BarButtonType) {
        let barButton = UIBarButtonItem(title: title, style: style, target: target, action: action)
        
        barButton.tintColor = Resource.Colors.darkGray
        
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
        
    // BarButton - image
    func addImgBarBtn(image: UIImage, style: UIBarButtonItem.Style, target: AnyObject?, action: Selector?, type: BarButtonType) {
        let barButton = UIBarButtonItem(image: image, style: style, target: target, action: action)
        
        barButton.tintColor = Resource.Colors.darkGray
        
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
}
