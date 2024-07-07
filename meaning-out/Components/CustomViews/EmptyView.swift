//
//  EmptyView.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit
import SnapKit

class EmptyView: BaseView {
    
    let emptyView = UIStackView()
    let emptyImage = UIImageView()
    let emptyLabel = UILabel()

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
        emptyLabel.text = Constants.Main.empty.rawValue
        emptyLabel.textAlignment = .center
    }
    
}
