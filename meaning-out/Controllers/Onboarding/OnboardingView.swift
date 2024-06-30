//
//  OnboardingView.swift
//  meaning-out
//
//  Created by junehee on 6/30/24.
//

import UIKit
import SnapKit

class OnboardingView: BaseView {
    
    let titleLabel = UILabel()
    let onboardingImage = UIImageView()
    let startButton = PointButton(title: Constants.Button.start.rawValue)
    
    
    override func configureViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(onboardingImage)
        self.addSubview(startButton)
    }
    
    override func configureViewLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(100)
        }
        
        onboardingImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureViewUI() {
        titleLabel.font = Resource.Fonts.mainTitle
        titleLabel.textColor = Resource.Colors.primary
        titleLabel.textAlignment = .center
        onboardingImage.contentMode = .scaleAspectFit
    }
    
}
