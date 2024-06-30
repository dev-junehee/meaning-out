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
        
        configureViewController()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureViewController() { }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() {
        view.backgroundColor = Resource.Colors.white
    }
    
}
