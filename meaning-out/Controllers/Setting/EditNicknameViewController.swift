//
//  EditNicknameViewController.swift
//  meaning-out
//
//  Created by junehee on 6/15/24.
//

import UIKit

import SnapKit
import TextFieldEffects

/**
 메인 - 설정 탭 - 프로필 수정 화면
 */
class EditNicknameViewController: UIViewController {
    
    let profileImageView = UIView()
    let profileImage = UIImageView()
    
    let cameraImageView = UIView()
    let cameraImage = UIImageView()
    
    let nicknameField = HoshiTextField()
    let invalidMessage = UILabel()
    
    var isValidate = false
    
    let isUser = UserDefaultsManager.isUser
    var nickname = UserDefaultsManager.nickname {
        didSet {
            UserDefaultsManager.nickname = nickname
        }
    }
    var profileNum = UserDefaultsManager.profile {
        didSet {
            profileImage.image = Resource.Images.profiles[profileNum]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureHandler()
    }
    
    private func configureView() {
        if !isUser {
            print("유효한 유저가 아닙니다.")
            // Onboarding 화면으로 돌리기
        }
        
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Title.edit.rawValue
        
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backBarButtonClicked), type: .left)
        addTextBarBtn(title: Constants.Button.save.rawValue, style: .plain, target: self, action: #selector(saveButtonClicked), type: .right)
    }
    
    private func configureHierarchy() {
        cameraImageView.addSubview(cameraImage)
        
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
        
        let subviews: [UIView] = [profileImageView, nicknameField, invalidMessage]
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(100)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.size.equalTo(profileImageView)
            $0.centerX.equalTo(profileImageView)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.trailing.equalTo(profileImage)
            $0.bottom.equalTo(profileImage).inset(8)
            $0.size.equalTo(24)
        }
        
        cameraImage.snp.makeConstraints {
            $0.center.equalTo(cameraImageView)
            $0.size.equalTo(15)
        }
        
        nicknameField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
        
        invalidMessage.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(30)
        }
    }
    
    private func configureUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50  // 추후 상수화 하기
        profileImage.layer.borderColor = Resource.Colors.primary.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
        profileImage.contentMode = .scaleAspectFit
        
        cameraImageView.backgroundColor = Resource.Colors.primary
        cameraImageView.layer.cornerRadius = 12  // 추후 상수화 하기
        
        cameraImage.image = Resource.SystemImages.camara
        cameraImage.contentMode = .scaleAspectFit
        cameraImage.tintColor = Resource.Colors.white
        
        nicknameField.setTextFieldUI(Constants.Placeholder.nickname.rawValue)
        nicknameField.returnKeyType = .done
        
        invalidMessage.textColor = Resource.Colors.primary
        invalidMessage.font = Resource.Fonts.regular13
    }
    
    private func configureData() {
        profileImage.image = Resource.Images.profiles[profileNum]
        nicknameField.text = nickname
    }
    
    private func configureHandler() {
        // 프로필 이미지 탭
        let profileTapped = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileImageView.addGestureRecognizer(profileTapped)
        profileImageView.isUserInteractionEnabled = true
        
        // 닉네임 유효성 검사, 키보드 내리기
        nicknameField.addTarget(self, action: #selector(validateNickname), for: .editingChanged)
        nicknameField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
    }
    
    
    // MARK: @objc 함수
    @objc func backBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func profileTapped() {
        let editProfileImageeVC = EditProfileImageViewController()
        navigationController?.pushViewController(editProfileImageeVC, animated: true)
    }
    
    @objc func validateNickname() {
        guard let nickname = nicknameField.text else {
            print(#function, "닉네임 입력값 오류")
            return
        }
        
        let result = getValidationResult(nickname)
        
        isValidate = result[0] as! Bool
        invalidMessage.text = result[1] as? String
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func saveButtonClicked() {
        // UserDefaults에 저장된 값과 nicknameField 값이 같을 경우
        if nickname == nicknameField.text {
            showAlert(title: Constants.Alert.SameNickname.title.rawValue,
                      message: Constants.Alert.SameNickname.message.rawValue,
                      type: .oneButton,
                      okHandler: alertReturn,
                      cancelHandler: nil)
            return
        }
        
        // 유효성 결과 미통과일 경우
        if !isValidate {
            showAlert(title: Constants.Alert.FailValidation.title.rawValue,
                      message: invalidMessage.text,
                      type: .oneButton,
                      okHandler: alertReturn,
                      cancelHandler: nil
            )
            return
        }
        
        // 유효성 검사 통과한 경우
        // 입력값 닉네임에 저장 - didSet으로 UserDefaults에 자동 저장
        guard let newNickname = nicknameField.text else { return }
        nickname = newNickname
        
        // 저장 완료되면 이전 화면으로 전환
        showAlert(title: Constants.Alert.EditNickname.title.rawValue,
                  message: Constants.Alert.EditNickname.message.rawValue,
                  type: .oneButton,
                  okHandler: alertPopViewController,
                  cancelHandler: nil)
    }
}


// MARK: Alert Action 알럿 액션 함수
extension EditNicknameViewController {
    func alertReturn(action: UIAlertAction) {
        return
    }
    
    func alertPopViewController(action: UIAlertAction) {
        navigationController?.popViewController(animated: true)
    }
}
