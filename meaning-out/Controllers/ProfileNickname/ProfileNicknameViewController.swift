//
//  ProfileNicknameViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

class ProfileNicknameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Text.Title.profile.rawValue
        
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backBarButtonClicked), type: .left)
    }
    
    @objc func backBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
