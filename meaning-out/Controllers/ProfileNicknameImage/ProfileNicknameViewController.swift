//
//  ProfileNicknameViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

import SnapKit
import TextFieldEffects

class ProfileNicknameViewController: UIViewController {
    
    let profileImageView = UIView()
    let profileImage = UIImageView()
    
    let cameraImageView = UIView()
    let cameraImage = UIImageView()
    
    let nicknameField = HoshiTextField()
    let invalidMessage = UILabel()
    
    let doneButton = PointButton(title: Constants.Button.done.rawValue)
    
    // 닉네임 유효성 검사 여부
    var isValidate = false
    
    // 유저 데이터
    var isUser = UserDefaultsManager.isUser
    var profileNum = UserDefaultsManager.profile {
        didSet {
            profileImage.image = Resource.Images.profiles[profileNum]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("맨 처음 찍히는", profileNum)
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("화면 전환 후 다시 돌아왔을 때", profileNum)
        
        // 화면 전환 시 저장됐던 프로필 이미지 가져오기
        profileNum = UserDefaultsManager.profile
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Title.profile.rawValue
        
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backBarButtonClicked), type: .left)
    }
    
    private func configureHierarchy() {
        cameraImageView.addSubview(cameraImage)
        
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
        
        let subviews: [UIView] = [profileImageView, nicknameField, invalidMessage, doneButton]
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
        
        doneButton.snp.makeConstraints {
            $0.top.equalTo(invalidMessage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
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
        // 기존 유저가 아닐 경우 프로필 이미지 랜덤
        if !isUser {
            profileNum = Int.random(in: 0...11)
        }
        
        UserDefaultsManager.profile = profileNum
        profileImage.image = Resource.Images.profiles[profileNum]
    }
    
    private func configureHandler() {
        // 프로필 이미지 탭
        let profileTapped = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileImageView.addGestureRecognizer(profileTapped)
        profileImageView.isUserInteractionEnabled = true
        
        // 닉네임 유효성 검사, 키보드 내리기
        nicknameField.addTarget(self, action: #selector(validateNickname), for: .editingChanged)
        nicknameField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
        
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    // MARK: @objc 함수
    @objc func backBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func profileTapped() {
        let profileImageVC = ProfileImageViewController()
        navigationController?.pushViewController(profileImageVC, animated: true)
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
    
    @objc func doneButtonClicked() {
        // 유효성 검사 미통과 시 실패 처리 - 추후 수정
        if !isValidate {
            print("유효성 검사 실패")
            return
        }
        
        // 유효성 검사 통과 시 프로필 사진/닉네임 저장
        print(isUser)
        
        guard let nickname = nicknameField.text else {
            return
        }
        UserDefaultsManager.nickname = nickname
        UserDefaultsManager.profile = profileNum
        UserDefaultsManager.joinDate = getTodayString(formatType: "yyyy. MM. dd")
        UserDefaultsManager.cart = []
        UserDefaultsManager.search = []
        UserDefaultsManager.isUser = true
    
        // rootViewController 변경
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        var rootViewController: UIViewController?
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = Resource.Colors.white
        tabBarController.tabBar.tintColor = Resource.Colors.primary
        
        let mainVC = UINavigationController(rootViewController: MainViewController())
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        
        let controllers = [mainVC, settingVC]
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.setTabBarUI()
        
        if let items = tabBarController.tabBar.items {
            items[0].title = Constants.Tab.search.rawValue
            items[0].image = Resource.SystemImages.search
            
            items[1].title = Constants.Tab.setting.rawValue
            items[1].image = Resource.SystemImages.person
        }
        
        rootViewController = tabBarController
            
        sceneDeleagate?.window?.rootViewController = rootViewController
        sceneDeleagate?.window?.makeKeyAndVisible()
    }

}
