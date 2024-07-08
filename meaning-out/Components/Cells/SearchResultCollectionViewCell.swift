//
//  SearchResultCollectionViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/18/24.
//

import UIKit

import Kingfisher
import SnapKit

/**
 검색 결과 화면 - 검색 아이템 셀
 */
class SearchResultCollectionViewCell: BaseCollectionViewCell {
    
    let itemView = UIStackView()
    
    let itemImage = UIImageView()
    let itemMallName = UILabel()
    let itemTitle = UILabel()
    let itemPrice = UILabel()
    
    let likeButton = UIButton()
    
    var likeList = UserDefaultsManager.like
    
    override func configureCellHierarchy() {
        let items = [itemImage, itemMallName, itemTitle, itemPrice]
        items.forEach {
            itemView.addArrangedSubview($0)
        }
        
        contentView.addSubview(itemView)
        contentView.addSubview(likeButton)
    }
    
    override func configureCellLayout() {
        itemView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        itemView.axis = .vertical
        
        itemImage.snp.makeConstraints {
            $0.top.equalTo(itemView.snp.top)
            $0.horizontalEdges.equalTo(itemView)
            $0.height.equalTo(itemImage.snp.width).multipliedBy(4.0/3.0)
        }
        
        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(itemImage.snp.trailing).inset(16)
            $0.bottom.equalTo(itemImage.snp.bottom).inset(16)
            $0.size.equalTo(36)
        }
        
        itemMallName.snp.makeConstraints {
            $0.top.equalTo(itemImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(itemView)
            $0.height.equalTo(20)
        }
        
        itemTitle.snp.makeConstraints {
            $0.top.equalTo(itemMallName.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(itemView)
            $0.height.equalTo(20)
        }
        
        itemPrice.snp.makeConstraints {
            $0.top.equalTo(itemTitle.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(itemView)
            $0.height.equalTo(30)
        }
    }
    
    override func configureCellUI() {
        itemImage.clipsToBounds = true
        itemImage.layer.cornerRadius = 10
        itemImage.contentMode = .scaleAspectFill
        
        likeButton.layer.cornerRadius = 10
        
        itemMallName.textColor = Resource.Colors.lightGray
        itemMallName.font = Resource.Fonts.regular13
        
        itemTitle.numberOfLines = 2
        itemTitle.font = Resource.Fonts.semiBold14
        
        itemPrice.font = Resource.Fonts.bold16
    }
    
    // 검색 결과 셀
    func configureCellData(data: Shopping) {
        let IMG_URL = URL(string: data.image)
        itemImage.kf.setImage(with: IMG_URL)
        
        likeButton.backgroundColor = data.isLike || UserDefaultsManager.like.contains(data.title) ? Resource.Colors.white : Resource.Colors.transparentBlack
        
        let likeImage = data.isLike || UserDefaultsManager.like.contains(data.title) ? Resource.SystemImages.likeSelected : Resource.SystemImages.likeUnselected
        likeButton.setImage(likeImage, for: .normal)
        
        if data.isLike {
            likeButton.tintColor = Resource.Colors.primary
        } else {
            likeButton.tintColor = Resource.Colors.white
        }
        
        itemMallName.text = data.mallName
        itemTitle.text = getItemTitle(data.title)
        itemPrice.text = "\(Int(data.lprice)?.formatted() ?? "-")원"
    }
    
    // 찜한 목록 셀
    func configureLikeCellData(data: LikeItemTable) {
        let IMG_URL = URL(string: data.image)
        itemImage.kf.setImage(with: IMG_URL)
        
        likeButton.backgroundColor = data.isLike || UserDefaultsManager.like.contains(data.title) ? Resource.Colors.white : Resource.Colors.transparentBlack
        
        let likeImage = data.isLike || UserDefaultsManager.like.contains(data.title) ? Resource.SystemImages.likeSelected : Resource.SystemImages.likeUnselected
        likeButton.setImage(likeImage, for: .normal)
        
        if data.isLike {
            likeButton.tintColor = Resource.Colors.primary
        } else {
            likeButton.tintColor = Resource.Colors.white
        }
        
        
        itemMallName.text = data.mallName
        itemTitle.text = getItemTitle(data.title)
        itemPrice.text = "\(Int(data.lprice)?.formatted() ?? "-")원"
    }
    
}
