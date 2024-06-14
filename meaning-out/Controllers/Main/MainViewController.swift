//
//  MainViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let nickname = UserDefaults.standard.string(forKey: Constants.Text.UserDefaults.nickname.rawValue) ?? "손님"

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = "\(nickname)'s MEANING OUT"
    }

}
