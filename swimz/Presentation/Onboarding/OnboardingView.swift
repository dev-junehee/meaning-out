//
//  OnboardingView.swift
//  meaning-out
//
//  Created by junehee on 6/30/24.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    
    private let titleLabel = UILabel()
    private let onboardingImage = UIImageView()
    let startButton = PointButton(title: Constants.Button.start.rawValue)
    
    override func configureViewHierarchy() {
        let subViews = [titleLabel, onboardingImage, startButton]
        subViews.forEach {
            self.addSubview($0)
        }
        UIFont.familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
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
        titleLabel.text = Constants.Title.swimz.rawValue
        titleLabel.textColor = Resource.Colors.primary
        titleLabel.textAlignment = .center
        titleLabel.font = Resource.Fonts.mainTitle
        onboardingImage.image = Resource.Images.launch
        onboardingImage.contentMode = .scaleAspectFit
    }
    
}
