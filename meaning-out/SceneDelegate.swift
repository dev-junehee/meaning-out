//
//  SceneDelegate.swift
//  meaning-out
//
//  Created by junehee on 6/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let isUser = UserDefaults.standard.bool(forKey: "isUser")
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        var rootViewController: UIViewController?
        
        if isUser {
            let tabBarController = UITabBarController()
            tabBarController.view.backgroundColor = Resource.Colors.white
            tabBarController.tabBar.tintColor = Resource.Colors.primary
            
            let main = UINavigationController(rootViewController: MainViewController())
            let setting = UINavigationController(rootViewController: SettingViewController())
            
            let controllers = [main, setting]
            tabBarController.setViewControllers(controllers, animated: true)
            
            if let items = tabBarController.tabBar.items {
                items[0].title = Constants.Text.Tab.search.rawValue
                items[0].image = Resource.SystemImages.search
                
                items[1].title = Constants.Text.Tab.setting.rawValue
                items[1].image = Resource.SystemImages.person
            }
            
            rootViewController = tabBarController
            
        } else {
            rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        }
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

