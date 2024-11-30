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
final class SettingMenuTableViewCell: BaseTableViewCell {
    
    let menuStack = UIStackView()
    
    let menuTitle = UILabel()
    
    let menuSubTitle = UIStackView()
    let likeImage = UIImageView()
    let likeCount = UILabel()
    let likeLabel = UILabel()
    
    private let repository = RealmLikeItemRepository()
    
    override func configureCellHierarchy() {
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
    
    override func configureCellLayout() {
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
    
    override func configureCellUI() {
        menuTitle.font = Resource.Fonts.regular14
        likeImage.tintColor = Resource.Colors.black
        likeImage.contentMode = .scaleAspectFit
        likeCount.font = Resource.Fonts.bold16
        likeLabel.font = Resource.Fonts.regular16
    }
    
    func configureLikeCellData(data: String) {
        menuTitle.text = data
        likeImage.image = Resource.SystemImages.likeSelected
        likeCount.text = repository.getAllLikeItemString()
        likeLabel.text = Constants.SettingOptions.like
    }
    
    func configureCellData(data: String) {
        menuTitle.text = data
        likeImage.image = nil
        likeCount.text = ""
        likeLabel.text = ""
    }
    
}
