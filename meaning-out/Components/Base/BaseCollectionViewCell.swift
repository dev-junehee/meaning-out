//
//  BaseCollectionViewCell.swift
//  meaning-out
//
//  Created by junehee on 7/8/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() { }
    
    func configureCellLayout() { }
    
    func configureCellUI() { }
    
}
