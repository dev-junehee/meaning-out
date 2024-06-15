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
    let cartImage = UIImageView()
    let cartCount = UILabel()
    let cartLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        let cartSubViews = [cartImage, cartCount, cartLabel]
        cartSubViews.forEach {
            menuSubTitle.addArrangedSubview($0)
        }
        
        let menuSubViews = [menuTitle, menuSubTitle]
        menuSubViews.forEach {
            menuStack.addArrangedSubview($0)
        }
        
        contentView.addSubview(menuStack)
    }
    
    func configureCellLayout() {
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
    
    func configureCellUI() {
        menuTitle.font = Resource.Fonts.regular14
        cartImage.tintColor = Resource.Colors.black
        cartImage.contentMode = .scaleAspectFit
        cartCount.font = Resource.Fonts.bold13
        cartLabel.font = Resource.Fonts.regular16
    }
    
    func configureCartCellData(data: String) {
        menuTitle.text = data
        cartImage.image = Resource.SystemImages.cart
        cartCount.text = "\(String(UserDefaultsManager.cart))개"
        cartLabel.text = "의 상품"
    }
    
    func configureCellData(data: String) {
        menuTitle.text = data
        cartLabel.text = ""
    }
    
}
