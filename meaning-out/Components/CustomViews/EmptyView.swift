//
//  EmptyView.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit
import SnapKit

class EmptyView: UIView {
    
    let emptyView = UIStackView()
    let emptyImage = UIImageView()
    let emptyLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Resource.Colors.white
    }
    
    private func configureHierarchy() {
        emptyView.addArrangedSubview(emptyImage)
        emptyView.addArrangedSubview(emptyLabel)
        addSubview(emptyView)
    }
    
    private func configureLayout() {
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyView.axis = .vertical
    }
    
    private func configureUI() {
        emptyImage.image = Resource.Images.empty
        emptyLabel.font = Resource.Fonts.bold16
        emptyLabel.text = Constants.Main.empty.rawValue
        emptyLabel.textAlignment = .center
    }
}
