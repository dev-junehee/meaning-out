//
//  OnboardingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import Foundation

final class OnboardingViewController: BaseViewController {
    
    private let mainView = OnboardingView()
    private let viewModel = OnboardingViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("OnboardingViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("OnboardingViewController Deinit") }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
    }
    
    private func bindData() {
        viewModel.transitionToProfileNickname = {
            let profileNicknameVC = ProfileNicknameViewController()
            self.navigationController?.pushViewController(profileNicknameVC, animated: true)
        }
    }
    
    private func configureHandler() {
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }

    @objc private func startButtonClicked() {
        viewModel.inputStartButtonClicked.value = ()
    }
    
}
