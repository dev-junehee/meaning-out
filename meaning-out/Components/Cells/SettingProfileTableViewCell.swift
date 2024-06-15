//
//  SettingProfileTableViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

/**
 설정 탭 - 프로필 정보 셀
 */
class SettingProfileTableViewCell: UITableViewCell {
    
    let profileStack = UIStackView()
    
    let profileImage = UIImageView()
    
    let profileInfoStack = UIStackView()
    let nicknameLabel = UILabel()
    let joinDateLabel = UILabel()
    
    let rightButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
        configureCellData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        let labelViews = [nicknameLabel, joinDateLabel]
        labelViews.forEach {
            profileInfoStack.addArrangedSubview($0)
        }
        
        let subViews = [profileImage, profileInfoStack, rightButton]
        subViews.forEach {
            profileStack.addArrangedSubview($0)
        }
    
        contentView.addSubview(profileStack)
    }
    
    func configureCellLayout() {
        profileStack.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView).inset(16)
            $0.horizontalEdges.equalTo(contentView).inset(16)
        }
        profileStack.axis = .horizontal
        profileStack.distribution = .equalSpacing
        
        profileImage.snp.makeConstraints {
            $0.leading.equalTo(profileStack.snp.leading)
            $0.verticalEdges.equalTo(profileStack)
            $0.width.equalTo(profileImage.snp.height)
        }
        
        profileInfoStack.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalTo(rightButton.snp.leading)
            $0.top.equalTo(profileStack.snp.top).offset(24)
            $0.bottom.equalTo(profileStack.snp.bottom).inset(24)
        }
        profileInfoStack.axis = .vertical
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileInfoStack.snp.leading).offset(16)
        }
        
        joinDateLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom)
            $0.leading.equalTo(profileInfoStack.snp.leading).offset(16)
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalTo(profileStack.snp.trailing).offset(16)
            $0.size.equalTo(20)
        }
    }
    
    func configureCellUI() {
        profileImage.layer.cornerRadius = 45
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderColor = Resource.Colors.primary.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)

        nicknameLabel.font = Resource.Fonts.bold16
        joinDateLabel.font = Resource.Fonts.regular13
        joinDateLabel.textColor = Resource.Colors.gray
        rightButton.tintColor = Resource.Colors.gray
    }
    
    func configureCellData() {
        let imageNum = UserDefaults.standard.integer(forKey: Constants.UserDefaults.profile.rawValue)
        profileImage.image = Resource.Images.profiles[imageNum]
       
        nicknameLabel.text = "JuneHee"
        joinDateLabel.text = "2024. 06. 15 가입"
        
        rightButton.setImage(Resource.SystemImages.right, for: .normal)
    }
    
}
