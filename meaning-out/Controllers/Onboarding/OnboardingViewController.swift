//
//  OnboardingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    let titleLabel = UILabel()
    let onboardingImage = UIImageView()
    let startButton = PointButton(title: Constants.Button.start.rawValue)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureHandler()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
    }
    
    private func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(onboardingImage)
        view.addSubview(startButton)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(100)
        }
        
        onboardingImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func configureUI() {
        titleLabel.font = Resource.Fonts.mainTitle
        titleLabel.textColor = Resource.Colors.primary
        titleLabel.textAlignment = .center
        
        onboardingImage.contentMode = .scaleAspectFit
    }
    
    private func configureData() {
        titleLabel.text = Constants.Title.main.rawValue
        onboardingImage.image = Resource.Images.launch
    }
    
    private func configureHandler() {
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }

    @objc func startButtonClicked() {
        let profileNicknameVC = ProfileNicknameViewController()
        navigationController?.pushViewController(profileNicknameVC, animated: true)
    }
}
