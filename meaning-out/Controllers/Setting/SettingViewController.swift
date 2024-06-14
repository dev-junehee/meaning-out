//
//  SettingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Text.Title.setting.rawValue
    }

}
