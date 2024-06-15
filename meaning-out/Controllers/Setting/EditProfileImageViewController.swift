//
//  EditProfileImageViewController.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit

import UIKit

class EditProfileImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("프로필 이미지 수정 화면 진입")
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Title.edit.rawValue
        
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backBarButtonClicked), type: .left)
    }

    @objc func backBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
