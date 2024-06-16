//
//  SearchItemTableViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit
import SnapKit

class SearchItemTableViewCell: UITableViewCell {
    
    let searchItemStack = UIStackView()
    
    let clockImage = UIImageView()
    let itemLabel = UILabel()
    let xmark = UIImageView()

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
        let subviews = [clockImage, itemLabel, xmark]
        subviews.forEach {
            searchItemStack.addSubview($0)
        }
        
        contentView.addSubview(searchItemStack)
    }
    
    func configureCellLayout() {
        searchItemStack.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.height.equalTo(40)
        }
        searchItemStack.axis = .horizontal
        searchItemStack.distribution = .equalSpacing
        
        clockImage.snp.makeConstraints {
            $0.verticalEdges.leading.equalTo(searchItemStack)
            $0.width.equalTo(16)
        }
        
        itemLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(searchItemStack)
            $0.leading.equalTo(clockImage.snp.trailing).offset(16)
            $0.trailing.equalTo(xmark.snp.leading)
        }
        
        xmark.snp.makeConstraints {
            $0.verticalEdges.trailing.equalTo(searchItemStack)
            $0.width.equalTo(16)
        }
    }
    
    func configureCellUI() {
        clockImage.image = Resource.SystemImages.clock
        clockImage.contentMode = .scaleAspectFit
        clockImage.tintColor = Resource.Colors.black
        
        itemLabel.font = Resource.Fonts.regular13
        
        xmark.image = Resource.SystemImages.xmark
        xmark.contentMode = .scaleAspectFit
        xmark.tintColor = Resource.Colors.gray
        
        // 임시 확인용
        itemLabel.text = "맥북 M4 에어 2024"
    }
}
