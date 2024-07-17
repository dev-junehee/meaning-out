//
//  ProfileNicknameViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

final class ProfileNicknameViewController: BaseViewController {
    
    private let mainView = ProfileNicknameView()
    private let viewModel = ProfileNicknameViewModel()
    
    // 닉네임 유효성 검사 여부, 가입 완료 여부, 프로필 이미지 번호
    var isValid = false
    var isUser = false

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("ProfileNicknameViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("ProfileNicknameViewController Deinit") }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        configureData()
        configureHandler()
        viewModel.inputViewDidLoadTrigger.value = ()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    private func bindData() {
        viewModel.outputProfileNum.bind { _ in
            self.configureData()
        }
        
        viewModel.outputIsValid.bind { value in
            self.isValid = value
        }
        
        viewModel.outputInvalidMessage.bind { message in
            self.mainView.invalidMessage.text = message
        }
        
        viewModel.outputSaveUserAccountResult.bind { value in
            self.isUser = value
        }
        
        viewModel.transitionProfileImage = {
            let profileImageVC = ProfileImageViewController()
            self.navigationController?.pushViewController(profileImageVC, animated: true)
        }
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.profile.rawValue
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(popViewController), type: .left)
    }
    
    private func configureData() {
        let profileNum = viewModel.outputProfileNum.value
        mainView.profileImage.image = Resource.Images.profiles[profileNum]
    }
    
    private func configureHandler() {
        // 프로필 이미지 탭
        let profileTapped = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        mainView.profileImageView.addGestureRecognizer(profileTapped)
        mainView.profileImageView.isUserInteractionEnabled = true
        
        // 닉네임 유효성 검사, 키보드 내리기
        mainView.nicknameField.addTarget(self, action: #selector(validateNickname), for: .editingChanged)
        mainView.nicknameField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    @objc private func profileTapped() {
        viewModel.inputProfileTapped.value = ()
    }
    
    @objc private func validateNickname() {
        viewModel.inputNickname.value = mainView.nicknameField.text
    }
    
    @objc private func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc private func doneButtonClicked() {
        // 유효성 검사 미통과 시 실패 처리 - 추후 수정
        if !isValid {
            showAlert(title: Constants.Alert.FailValidation.title.rawValue,
                      message: viewModel.outputInvalidMessage.value,
                      type: .oneButton,
                      okHandler: nil)
            return
        }
        
        viewModel.inputDoneButtonClicked.value = ()
        
        if isUser {
            changeRootViewController()
        }
    }

}
