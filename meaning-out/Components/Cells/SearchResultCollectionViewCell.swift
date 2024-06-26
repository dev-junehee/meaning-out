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
class SearchResultCollectionViewCell: UICollectionViewCell {
    
    let itemView = UIStackView()
    
    let itemImage = UIImageView()
    let itemMallName = UILabel()
    let itemTitle = UILabel()
    let itemPrice = UILabel()
    
    let likeButton = UIButton()
    
    var cartList = UserDefaultsManager.cart
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
        configureHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        let items = [itemImage, itemMallName, itemTitle, itemPrice]
        items.forEach {
            itemView.addArrangedSubview($0)
        }
        
        contentView.addSubview(itemView)
        contentView.addSubview(likeButton)
    }
    
    func configureCellLayout() {
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
    
    func configureCellUI() {
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
    
    func configureCellData(data: SearchItem) {
        let IMG_URL = URL(string: data.image)
        itemImage.kf.setImage(with: IMG_URL)
        
        likeButton.backgroundColor = data.isLike || UserDefaultsManager.cart.contains(data.title) ? Resource.Colors.white : Resource.Colors.transparentBlack
        
        let likeImage = data.isLike || UserDefaultsManager.cart.contains(data.title) ? Resource.Images.likeSelected : Resource.Images.likeUnselected
        likeButton.setImage(likeImage, for: .normal)
        
        itemMallName.text = data.mallName
        itemTitle.text = getItemTitle(data.title)
        itemPrice.text = "\(Int(data.lprice)?.formatted() ?? "-")원"
    }
    
    func configureHandler() {
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    }
    
    @objc func likeButtonClicked() {
        guard let itemTitle = itemTitle.text else { return }
        // UserDefaults에 좋아요 상품명 저장
        cartList.append(itemTitle)
        UserDefaultsManager.cart = cartList
    }
}
