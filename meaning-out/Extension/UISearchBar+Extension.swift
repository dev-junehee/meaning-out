//
//  UISearchBar+Extension.swift
//  meaning-out
//
//  Created by junehee on 11/29/24.
//

import UIKit

extension UISearchBar {
    func setPlaceholderFont(_ font: UIFont) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(
                string: textField.placeholder ?? "",
                attributes: [NSAttributedString.Key.font: font]
            )
        }
    }
}
