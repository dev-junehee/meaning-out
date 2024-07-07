//
//  SettingMenuTableViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

/**
 설정 탭 - 메뉴 셀
 */
class SettingMenuTableViewCell: UITableViewCell {
    
    let menuStack = UIStackView()
    
    let menuTitle = UILabel()
    
    let menuSubTitle = UIStackView()
    let likeImage = UIImageView()
    let likeCount = UILabel()
    let likeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCellHierarchy() {
        let likeSubViews = [likeImage, likeCount, likeLabel]
        likeSubViews.forEach {
            menuSubTitle.addArrangedSubview($0)
        }
        
        let menuSubViews = [menuTitle, menuSubTitle]
        menuSubViews.forEach {
            menuStack.addArrangedSubview($0)
        }
        
        contentView.addSubview(menuStack)
    }
    
    private func configureCellLayout() {
        menuStack.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        menuStack.axis = .horizontal
        menuStack.distribution = .equalSpacing
        
        menuTitle.snp.makeConstraints {
            $0.verticalEdges.equalTo(menuStack)
            $0.leading.equalTo(menuStack.snp.leading).offset(24)
        }
        
        menuSubTitle.snp.makeConstraints {
            $0.verticalEdges.equalTo(menuStack)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(24)
        }
    }
    
    private func configureCellUI() {
        menuTitle.font = Resource.Fonts.regular14
        likeImage.tintColor = Resource.Colors.black
        likeImage.contentMode = .scaleAspectFit
        likeCount.font = Resource.Fonts.bold13
        likeLabel.font = Resource.Fonts.regular16
    }
    
    func configureLikeCellData(data: String) {
        menuTitle.text = data
        likeImage.image = Resource.SystemImages.likeSelected
        likeCount.text = UserDefaultsManager.getLikeLabel()
        likeLabel.text = Constants.SettingOptions.like
    }
    
    func configureCellData(data: String) {
        menuTitle.text = data
        likeImage.image = nil
        likeCount.text = ""
        likeLabel.text = ""
    }
    
}
