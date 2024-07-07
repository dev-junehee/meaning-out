//
//  SearchItemTableViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit
import SnapKit

class SearchItemTableViewCell: UITableViewCell {
    
    let clockImage = UIImageView()
    let itemLabel = UILabel()
    let xmark = UIButton()
    
    var searchList = UserDefaultsManager.search

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
        contentView.addSubview(clockImage)
        contentView.addSubview(itemLabel)
        contentView.addSubview(xmark)
    }
    
    func configureCellLayout() {
        clockImage.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(16)
            $0.verticalEdges.equalTo(contentView)
            $0.width.equalTo(16)
        }
        
        itemLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.leading.equalTo(clockImage.snp.trailing).offset(16)
            $0.trailing.equalTo(xmark.snp.leading)
        }
        
        xmark.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(16)
            $0.verticalEdges.equalTo(contentView)
            $0.width.equalTo(16)
        }
    }
    
    func configureCellUI() {
        clockImage.image = Resource.SystemImages.clock
        clockImage.contentMode = .scaleAspectFit
        clockImage.tintColor = Resource.Colors.black

        itemLabel.textColor = Resource.Colors.black
        itemLabel.font = Resource.Fonts.regular14
        itemLabel.textAlignment = .left
        
        xmark.setImage(Resource.SystemImages.xmark, for: .normal)
        xmark.contentMode = .scaleAspectFit
        xmark.tintColor = Resource.Colors.gray
    }
    
    func configureCellData(data: String) {
        itemLabel.text = data
    }
    
}
