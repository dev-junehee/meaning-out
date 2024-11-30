//
//  UIButton+Extension.swift
//  meaning-out
//
//  Created by junehee on 6/22/24.
//

import UIKit

/**
 검색 결과 화면 버튼 UI
 */
extension UIButton {
    func setClickedButtonUI() {
        self.backgroundColor = Resource.Colors.darkGray
        self.setTitleColor(Resource.Colors.white, for: .normal)
        self.layer.borderWidth = 0
    }

    func setUnclickedButtonUI() {
        self.backgroundColor = Resource.Colors.white
        self.setTitleColor(Resource.Colors.black, for: .normal)
        self.layer.borderWidth = 1
    }
}
