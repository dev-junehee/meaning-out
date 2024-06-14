//
//  ProfileImageViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

class ProfileImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Text.Title.profile.rawValue
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backButtonClicked), type: .left)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
