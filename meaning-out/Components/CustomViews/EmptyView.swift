//
//  EmptyView.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit
import SnapKit

enum EmptyViewType {
    case search
    case like
}

final class EmptyView: BaseView {
    
    private let emptyView = UIStackView()
    private let emptyImage = UIImageView()
    private let emptyLabel = UILabel()
    
    var emptyViewType: EmptyViewType = .search

    override func configureViewHierarchy() {
        emptyView.addArrangedSubview(emptyImage)
        emptyView.addArrangedSubview(emptyLabel)
        addSubview(emptyView)
    }
    
    override func configureViewLayout() {
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyView.axis = .vertical
        emptyView.spacing = 8
    }
    
    override func configureViewUI() {
        backgroundColor = Resource.Colors.white
        emptyImage.image = Resource.Images.empty
        emptyLabel.font = Resource.Fonts.bold16
        emptyLabel.textAlignment = .center
        
        switch emptyViewType {
        case .search:
            emptyLabel.text = Constants.Search.empty.rawValue
        case .like:
            emptyLabel.text = Constants.Like.empty.rawValue
        }
    }
    
}
