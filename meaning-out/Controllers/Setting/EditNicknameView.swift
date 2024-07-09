//
//  EditNicknameView.swift
//  meaning-out
//
//  Created by junehee on 7/9/24.
//

import UIKit

import SnapKit
import TextFieldEffects

final class EditNicknameView: BaseView {
    
    let profileImageView = UIView()
    let profileImage = UIImageView()
    
    let cameraImageView = UIView()
    let cameraImage = UIImageView()
    
    let nicknameField = HoshiTextField()
    let invalidMessage = UILabel()
    
    override func configureViewHierarchy() {
        cameraImageView.addSubview(cameraImage)
        
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
        
        let subviews: [UIView] = [profileImageView, nicknameField, invalidMessage]
        subviews.forEach { subview in
            self.addSubview(subview)
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
    }
    
    override func configureViewUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50  // 추후 상수화 하기
        profileImage.layer.borderColor = Resource.Colors.primary.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
        profileImage.contentMode = .scaleAspectFit
        
        cameraImageView.backgroundColor = Resource.Colors.primary
        cameraImageView.layer.cornerRadius = 12  // 추후 상수화 하기
        
        cameraImage.image = Resource.SystemImages.camara
        cameraImage.contentMode = .scaleAspectFit
        cameraImage.tintColor = Resource.Colors.white
        
        nicknameField.setTextFieldUI(Constants.Placeholder.nickname.rawValue)
        nicknameField.returnKeyType = .done
        
        invalidMessage.textColor = Resource.Colors.primary
        invalidMessage.font = Resource.Fonts.regular13
    }
}
