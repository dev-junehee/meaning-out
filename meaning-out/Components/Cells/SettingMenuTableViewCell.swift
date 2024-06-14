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
    let menuSubTitle = UIButton()
    
    let cartCount = UILabel()   // 임시 데이터
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
        
        cartCount.text = "0개"
        cartCount.font = Resource.Fonts.bold14
        cartLabel.text = "의 상품"
        cartLabel.font = Resource.Fonts.regular14
    }
    
    func configureCartCellData(data: String) {
        menuTitle.text = data
        
        guard let cartCount = cartCount.text, let cartLabel = cartLabel.text else { return }
        menuSubTitle.setImage(Resource.SystemImages.cart, for: .normal)
        menuSubTitle.setTitle("\(cartCount)\(cartLabel)", for: .normal)
        menuSubTitle.setTitleColor(Resource.Colors.black, for: .normal)
        menuSubTitle.titleLabel?.font = Resource.Fonts.regular14
        menuSubTitle.tintColor = Resource.Colors.black
    }
    
    func configureCellData(data: String) {
        menuTitle.text = data
        menuSubTitle.setTitle("", for: .normal)
    }
    
}
