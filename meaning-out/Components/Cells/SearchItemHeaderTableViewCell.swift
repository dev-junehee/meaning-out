//
//  SearchItemTitleTableViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/17/24.
//

import UIKit
import SnapKit

final class SearchItemHeaderTableViewCell: BaseTableViewCell {
    
    let titleStack = UIStackView()
    
    let recentTitle = UILabel()
    let removeTitle = UIButton()
    
    override func configureCellHierarchy() {
        let titleViews = [recentTitle, removeTitle]
        titleViews.forEach {
            titleStack.addArrangedSubview($0)
        }
        
        contentView.addSubview(titleStack)
    }
    
    override func configureCellLayout() {
        titleStack.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.height.equalTo(40)
        }
        titleStack.axis = .horizontal
        titleStack.distribution = .equalSpacing
        
        recentTitle.snp.makeConstraints {
            $0.verticalEdges.equalTo(titleStack)
            $0.leading.equalTo(titleStack.snp.leading)
        }
        
        removeTitle.snp.makeConstraints {
            $0.verticalEdges.trailing.equalTo(titleStack)
            $0.trailing.equalTo(titleStack.snp.trailing)
        }
    }
    
    override func configureCellUI() {
        recentTitle.font = Resource.Fonts.bold16
        recentTitle.text = Constants.Main.recent.rawValue
        
        removeTitle.setTitle(Constants.Main.remove.rawValue, for: .normal)
        removeTitle.setTitleColor(Resource.Colors.primary, for: .normal)
        removeTitle.titleLabel?.font = Resource.Fonts.bold13
    }
    
}
