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
    let itemLabel = UIButton()
    let xmark = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
        configureHandler()
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
        
        itemLabel.setTitleColor(Resource.Colors.black, for: .normal)
        itemLabel.titleLabel?.font = Resource.Fonts.regular13
        itemLabel.titleLabel?.textAlignment = .left
        itemLabel.contentHorizontalAlignment = .left
        
        xmark.setImage(Resource.SystemImages.xmark, for: .normal)
        xmark.contentMode = .scaleAspectFit
        xmark.tintColor = Resource.Colors.gray
    }
    
    func configureCellData(data: String) {
        itemLabel.setTitle(data, for: .normal)
    }
    
    func configureHandler() {
        itemLabel.addTarget(self, action: #selector(searchItemClicked), for: .touchUpInside)
        xmark.addTarget(self, action: #selector(xmarkClicked), for: .touchUpInside)
    }
    
    @objc func searchItemClicked() {
        // 해당 검색어로 구성된 검색 결과 화면 연결
        print("아이템 클릭!!!!!!")
    }
    
    @objc func xmarkClicked() {
        // 검색 리스트에서 해당 검색어 삭제
        print("X버튼 클릭!!!!")
    }
}
