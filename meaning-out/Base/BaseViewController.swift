//
//  BaseViewController.swift
//  meaning-out
//
//  Created by junehee on 6/30/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() {
        view.backgroundColor = Resource.Colors.white
    }
    
}
