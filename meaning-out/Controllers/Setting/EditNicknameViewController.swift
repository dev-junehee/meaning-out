//
//  EditNicknameViewController.swift
//  meaning-out
//
//  Created by junehee on 6/15/24.
//

import UIKit

class EditNicknameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = "EDIT PROFILE"
        
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backButtonClicked), type: .left)
        addTextBarBtn(title: Constants.Text.Button.save.rawValue, style: .plain, target: self, action: #selector(saveButtonClicked), type: .right)
    }
    
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonClicked() {
        print("저장 버튼 눌렀어요")
    }
}
