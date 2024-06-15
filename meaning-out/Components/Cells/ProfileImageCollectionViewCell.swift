//
//  ProfileImageCollectionViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {

    var isActive = false // 사용자가 이미 선택한 값
    
    let profileImageView = UIView()
    let profileImage = UIImageView()
    
    var itemNum: Int?
    let profileNum = UserDefaults.standard.integer(forKey: Constants.UserDefaults.profile.rawValue)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellHierarchy()
        configureCellLayout()
        configureSelectedCellUI()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func configureCellHierarchy() {
        profileImageView.addSubview(profileImage)
        contentView.addSubview(profileImageView)
    }
    
    func configureCellLayout() {
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
    
    func configureCellUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 35  // 추후 상수화 하기
        profileImage.contentMode = .scaleAspectFit

//        if isActive {
//            profileImageView.alpha = 1.0
//            profileImage.layer.borderColor = Resource.Colors.primary.cgColor
//            profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
//        } else {
            profileImageView.alpha = 0.5
            profileImage.layer.borderColor = Resource.Colors.lightGray.cgColor
            profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidthEnabled.rawValue)
//        }
    }
    
    func configureSelectedCellUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 35  // 추후 상수화 하기
        profileImage.contentMode = .scaleAspectFit
        
        profileImageView.alpha = 1.0
        profileImage.layer.borderColor = Resource.Colors.primary.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
    }
    
    func configureCellData(data: UIImage) {
        profileImage.image = data
    }
    
}
