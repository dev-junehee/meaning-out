//
//  ProfileImageCollectionViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

/**
 프로필 이미지 설정 화면 - 프로필 이미지 셀
 */
final class ProfileImageCollectionViewCell: BaseCollectionViewCell {
    
    let profileImageView = UIView()
    let profileImage = UIImageView()
    
    var itemNum: Int?
    let profileNum = UserDefaultsManager.profile

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layoutIfNeeded()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    // 선택한 Cell에 대한 UI
    override var isSelected: Bool{
        didSet {
            if isSelected {
                profileImageView.alpha = 1.0
                profileImage.layer.borderColor = Resource.Colors.primary.cgColor
                profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
            } else {
                profileImageView.alpha = 0.5
                profileImage.layer.borderColor = Resource.Colors.lightGray.cgColor
                profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidthEnabled.rawValue)
            }
        }
    }
    
    override func configureCellHierarchy() {
        profileImageView.addSubview(profileImage)
        contentView.addSubview(profileImageView)
    }
    
    override func configureCellLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(16)
            $0.size.equalTo(70)
            $0.centerX.equalTo(contentView)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.size.equalTo(profileImageView)
            $0.centerX.equalTo(profileImageView)
        }
    }
    
    override func configureCellUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.contentMode = .scaleAspectFit
        
        profileImageView.alpha = 0.5
        profileImage.layer.borderColor = Resource.Colors.lightGray.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidthEnabled.rawValue)
    }
    
    func configureSelectedCellUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.contentMode = .scaleAspectFit
        
        profileImageView.alpha = 1.0
        profileImage.layer.borderColor = Resource.Colors.primary.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
    }
    
    func configureCellData(data: UIImage) {
        profileImage.image = data
    }
    
}
