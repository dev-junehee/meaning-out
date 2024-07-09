//
//  EditNicknameViewController.swift
//  meaning-out
//
//  Created by junehee on 6/15/24.
//

import UIKit

/**
 메인 - 설정 탭 - 프로필 수정 화면
 */
final class EditNicknameViewController: BaseViewController {
    
    private var editNicknameView = EditNicknameView()
    
    var isValidate = false
    
    let isUser = UserDefaultsManager.isUser
    var nickname = UserDefaultsManager.nickname {
        didSet {
            UserDefaultsManager.nickname = nickname
        }
    }
    var profileNum = UserDefaultsManager.profile {
        didSet {
            editNicknameView.profileImage.image = Resource.Images.profiles[profileNum]
        }
    }
    
    let viewModel = EditNicknameViewModel()
    
    override func loadView() {
        self.view = editNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureHandler()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileNum = UserDefaultsManager.profile
    }
    
    private func bindData() {
        viewModel.outputIsValid.bind { value in
            self.isValidate = value
        }
        
        viewModel.outputInvalidMessage.bind { message in
            self.editNicknameView.invalidMessage.text = message
        }
        
        viewModel.outputAlertText.bind { (isValid, title, message) in
            if isValid {
                self.showAlert(
                    title: Constants.Alert.EditNickname.title.rawValue,
                    message: Constants.Alert.EditNickname.message.rawValue,
                    type: .oneButton,
                    okHandler: self.alertPopViewController)
            } else {
                self.showAlert(title: title, message: message, type: .oneButton) { _ in
                    return
                }
            }
        }
    }
    
    override func configureViewController() {
        if !isUser {
            showAlert(
                title: Constants.Alert.InvalidUser.title.rawValue,
                message: Constants.Alert.InvalidUser.message.rawValue,
                type: .oneButton,
                okHandler: backOnboardingController)
            return
        }
        
        navigationItem.title = Constants.Title.edit.rawValue
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(popViewController), type: .left)
        addTextBarBtn(title: Constants.Button.save.rawValue, style: .plain, target: self, action: #selector(saveButtonClicked), type: .right)
    }
    
    private func configureData() {
        editNicknameView.profileImage.image = Resource.Images.profiles[profileNum]
        editNicknameView.nicknameField.text = nickname
    }
    
    private func configureHandler() {
        // 프로필 이미지 탭
        let profileTapped = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        editNicknameView.profileImageView.addGestureRecognizer(profileTapped)
        editNicknameView.profileImageView.isUserInteractionEnabled = true
        
        // 닉네임 유효성 검사, 키보드 내리기
        editNicknameView.nicknameField.addTarget(self, action: #selector(nicknameFieldChanged), for: .editingChanged)
        editNicknameView.nicknameField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
    }
    
    @objc func profileTapped() {
        let editProfileImageeVC = EditProfileImageViewController()
        navigationController?.pushViewController(editProfileImageeVC, animated: true)
    }
    
    @objc func nicknameFieldChanged() {
        viewModel.inputNickname.value = editNicknameView.nicknameField.text
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func saveButtonClicked() {
        viewModel.inputNickname.value = editNicknameView.nicknameField.text
        viewModel.inputOriginNickname.value = nickname
        viewModel.inputSaveButtonClicked.value = ()
    }
}


// MARK: EditNicknameViewController 익스텐션
extension EditNicknameViewController {
    // Alert Action 알럿 액션 함수
    func alertReturn(action: UIAlertAction) {
        return
    }
    
    func alertPopViewController(action: UIAlertAction) {
        navigationController?.popViewController(animated: true)
    }
    
    // 온보딩으로 root 바꾸기
    func backOnboardingController(action: UIAlertAction) {
        // UserDefaults에 저장된 모든 데이터 삭제
        UserDefaultsManager.deleteAllUserDefaults()
        
        // 온보딩 화면으로 전환
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        let onboardingVC = UINavigationController(rootViewController: OnboardingViewController())
        let rootViewController = onboardingVC
        
        sceneDeleagate?.window?.rootViewController = rootViewController
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
}
