//
//  PointButton.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

class PointButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
    
        backgroundColor = Resource.Colors.primary
        layer.cornerRadius = CGFloat(Constants.Integer.buttonRadius.rawValue)
        
        setTitle(title, for: .normal)
        setTitleColor(Resource.Colors.white, for:.normal)
        titleLabel?.font = Resource.Fonts.button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

