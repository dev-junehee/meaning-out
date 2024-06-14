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
    
    func showAlert(title: String?, message: String?, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "확인", style: .default, handler: okHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: cancelHandler)

        alert.addAction(okay)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
