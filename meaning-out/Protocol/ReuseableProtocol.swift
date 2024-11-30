//
//  ReuseableProtocol.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

protocol ReuseableProtocol: AnyObject {
    static var id: String { get }
}

extension UIView: ReuseableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
