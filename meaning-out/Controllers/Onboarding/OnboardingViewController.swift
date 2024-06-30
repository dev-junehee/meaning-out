//
//  OnboardingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

class OnboardingViewController: BaseViewController {
    
    let onboardingView = OnboardingView()
    
    override func loadView() {
        self.view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureHandler()
    }
    
    private func configureData() {
        onboardingView.titleLabel.text = Constants.Title.meaningout.rawValue
        onboardingView.onboardingImage.image = Resource.Images.launch
    }
    
    private func configureHandler() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }

    @objc func startButtonClicked() {
        let profileNicknameVC = ProfileNicknameViewController()
        navigationController?.pushViewController(profileNicknameVC, animated: true)
    }
    
}
