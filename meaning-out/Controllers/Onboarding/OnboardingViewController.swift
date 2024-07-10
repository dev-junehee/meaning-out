//
//  OnboardingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import Foundation

final class OnboardingViewController: BaseViewController {
    
    private let onboardingView = OnboardingView()
    
    override func loadView() {
        self.view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
    }
    
    override func configureUI() {
        super.configureUI()
        onboardingView.titleLabel.text = Constants.Title.meaningout.rawValue
        onboardingView.onboardingImage.image = Resource.Images.launch
    }
    
    private func configureHandler() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }

    @objc private func startButtonClicked() {
        let profileNicknameVC = ProfileNicknameViewController()
        navigationController?.pushViewController(profileNicknameVC, animated: true)
    }
    
}
