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
    
    // Alert
    func showAlert(title: String?, message: String?, type: AlertType, okHandler: ((UIAlertAction) -> Void)?) {
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
            let cancel = UIAlertAction(title: Constants.Button.cancel.rawValue, style: .cancel)
            alert.addAction(okay)
            alert.addAction(cancel)
            break
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // Alert - TextField
    func showTextFieldAlert(title: String, message: String? = nil, placeholder: String? = nil,  okHandler: ((String?) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        let okay = UIAlertAction(title: Constants.Button.okay.rawValue, style: .default) { ok in
            let textFieldText = alert.textFields?.first?.text
            okHandler?(textFieldText)
        }
        let cancel = UIAlertAction(title: Constants.Button.cancel.rawValue, style: .cancel)
        alert.addAction(okay)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    // 찜 상품 저장 시 카테고리 선택창
    func showCategoryActionSheet(_ actionList: [LikeCategory], completion: ((String?) -> Void)?) {
        let alert = UIAlertController(
            title: Constants.Alert.SelectLikeCategory.title.rawValue,
            message: nil,
            preferredStyle: .actionSheet)
        
        actionList.forEach {
            alert.addAction(UIAlertAction(title: $0.title, style: .default, handler: { action in
                completion?(action.title)
            }))
        }
        
        let cancel = UIAlertAction(title: Constants.Button.cancel.rawValue, style: .cancel)
        alert.addAction(cancel)

        present(alert, animated: true)
    }
    
    func changeRootViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        var rootViewController: UIViewController?
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = Resource.Colors.white
        tabBarController.tabBar.tintColor = Resource.Colors.primary
        
        let mainVC = UINavigationController(rootViewController: SearchViewController())
        let likeVC = UINavigationController(rootViewController: LikeCategoryViewController())
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        
        let controllers = [mainVC, likeVC, settingVC]
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.setTabBarUI()
        
        if let items = tabBarController.tabBar.items {
            items[0].title = Constants.Tab.search.rawValue
            items[0].image = Resource.SystemImages.search
            
            items[1].title = Constants.Tab.like.rawValue
            items[1].image = Resource.SystemImages.like
            
            items[2].title = Constants.Tab.setting.rawValue
            items[2].image = Resource.SystemImages.person
        }
        
        rootViewController = tabBarController
            
        sceneDeleagate?.window?.rootViewController = rootViewController
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
    func changeRootViewControllerToOnboarding() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        let onboardingVC = UINavigationController(rootViewController: OnboardingViewController())
        let rootViewController = onboardingVC
        
        sceneDeleagate?.window?.rootViewController = rootViewController
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
