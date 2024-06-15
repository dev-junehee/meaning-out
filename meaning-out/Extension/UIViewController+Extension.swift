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

enum AlertType {
    case oneButton
    case twoButton
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
    
    func showAlert(title: String?, message: String?, type: AlertType, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        switch type {
        case .oneButton:
            let okay = UIAlertAction(title: Constants.Button.okay.rawValue, style: .default, handler: okHandler)
            alert.addAction(okay)
            break
        case .twoButton:
            let okay = UIAlertAction(title: Constants.Button.okay.rawValue, style: .default, handler: okHandler)
            let cancel = UIAlertAction(title: Constants.Button.cancel.rawValue, style: .cancel, handler: cancelHandler)
            alert.addAction(okay)
            alert.addAction(cancel)
            break
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
