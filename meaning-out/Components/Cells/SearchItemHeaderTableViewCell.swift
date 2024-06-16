//
//  SearchItemTitleTableViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/17/24.
//

import UIKit
import SnapKit

class SearchItemHeaderTableViewCell: UITableViewCell {
    
    let titleStack = UIStackView()
    
    let recentTitle = UILabel()
    let removeTitle = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        cofigureCellUI()
        configureHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCellHierarchy() {
        let titleViews = [recentTitle, removeTitle]
        titleViews.forEach {
            titleStack.addArrangedSubview($0)
        }
        
        contentView.addSubview(titleStack)
    }
    
    private func configureCellLayout() {
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
    
    private func cofigureCellUI() {
        recentTitle.font = Resource.Fonts.bold16
        recentTitle.text = "최근 검색"
        
        removeTitle.setTitle("전체 삭제", for: .normal)
        removeTitle.setTitleColor(Resource.Colors.primary, for: .normal)
        removeTitle.titleLabel?.font = Resource.Fonts.bold13

    }
    
    private func configureHandler() {
        removeTitle.addTarget(self, action: #selector(removeAllSearchList), for: .touchUpInside)
    }

    @objc func removeAllSearchList() {
        print("전체삭제 버튼 클릭")
    }
}
