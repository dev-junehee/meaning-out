//
//  MainViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

/**
 메인 - 검색 탭
 */
class MainViewController: UIViewController {

    let nickname = UserDefaultsManager.nickname

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Title.main
    }

}
