//
//  ProfileNicknameView.swift
//  meaning-out
//
//  Created by junehee on 6/30/24.
//

import UIKit

import SnapKit
import TextFieldEffects

final class ProfileNicknameView: BaseView {
    
    let profileImageView = UIView()
    let profileImage = UIImageView()
    
    private let cameraImageView = UIView()
    private let cameraImage = UIImageView()
    
    let nicknameField = HoshiTextField()
    let invalidMessage = UILabel()
    
    let doneButton = PointButton(title: Constants.Button.done.rawValue)
    
    var isEditmode = false {
        didSet {
            doneButton.isHidden = isEditmode
        }
    }
    
    override func configureViewHierarchy() {
        cameraImageView.addSubview(cameraImage)
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
        
        let subviews = [profileImageView, nicknameField, invalidMessage, doneButton]
        subviews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(100)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.size.equalTo(profileImageView)
            $0.centerX.equalTo(profileImageView)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.trailing.equalTo(profileImage)
            $0.bottom.equalTo(profileImage).inset(8)
            $0.size.equalTo(24)
        }
        
        cameraImage.snp.makeConstraints {
            $0.center.equalTo(cameraImageView)
            $0.size.equalTo(15)
        }
        
        nicknameField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
        
        invalidMessage.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(30)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.equalTo(invalidMessage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
    }
    
    override func configureViewUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50
        profileImage.layer.borderColor = Resource.Colors.primary.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
        profileImage.contentMode = .scaleAspectFit
        
        cameraImageView.backgroundColor = Resource.Colors.primary
        cameraImageView.layer.cornerRadius = 12
        
        cameraImage.image = Resource.SystemImages.camara
        cameraImage.contentMode = .scaleAspectFit
        cameraImage.tintColor = Resource.Colors.white
        
        nicknameField.setTextFieldUI(Constants.Placeholder.nickname.rawValue)
        nicknameField.returnKeyType = .done
        
        invalidMessage.textColor = Resource.Colors.primary
        invalidMessage.font = Resource.Fonts.regular13
    }
    
}
