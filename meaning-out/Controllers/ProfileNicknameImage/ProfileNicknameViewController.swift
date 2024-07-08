//
//  ProfileNicknameViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import TextFieldEffects

final class ProfileNicknameViewController: BaseViewController {
    
    private let nicknameView = ProfileNicknameView()
    
    // 닉네임 유효성 검사 여부
    var isValidate = false
    
    // 유저 데이터
    var isUser = UserDefaultsManager.isUser
    var profileNum = UserDefaultsManager.profile {
        didSet {
            nicknameView.profileImage.image = Resource.Images.profiles[profileNum]
        }
    }
    
    override func loadView() {
        self.view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureHandler()
    }
 
    // 화면 전환 후 다시 돌아왔을 때 필요한 부분 처리
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 저장됐던 프로필 이미지 가져오기
        profileNum = UserDefaultsManager.profile
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.profile.rawValue
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(popViewController), type: .left)
    }
    
    private func configureData() {
        // 기존 유저가 아닐 경우 프로필 이미지 랜덤
        if !isUser {
            profileNum = Int.random(in: 0...11)
        }
        
        UserDefaultsManager.profile = profileNum
        nicknameView.profileImage.image = Resource.Images.profiles[profileNum]
    }
    
    private func configureHandler() {
        // 프로필 이미지 탭
        let profileTapped = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        nicknameView.profileImageView.addGestureRecognizer(profileTapped)
        nicknameView.profileImageView.isUserInteractionEnabled = true
        
        // 닉네임 유효성 검사, 키보드 내리기
        nicknameView.nicknameField.addTarget(self, action: #selector(validateNickname), for: .editingChanged)
        nicknameView.nicknameField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
        nicknameView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    @objc private func profileTapped() {
        let profileImageVC = ProfileImageViewController()
        navigationController?.pushViewController(profileImageVC, animated: true)
    }
    
    @objc private func validateNickname() {
        guard let nickname = nicknameView.nicknameField.text else { return }
        
        do {
            let result = try getValidationResult(nickname)
            if result {
                isValidate = true
                nicknameView.invalidMessage.text = Constants.Validation.Nickname.success.rawValue
            }
        } catch ValidationError.empty {
            isValidate = false
            nicknameView.invalidMessage.text = Constants.Validation.Nickname.empty.rawValue
        } catch ValidationError.hasSpecialChar{
            isValidate = false
            nicknameView.invalidMessage.text = Constants.Validation.Nickname.hasSpecialChar.rawValue
        } catch ValidationError.hasNumber {
            isValidate = false
            nicknameView.invalidMessage.text = Constants.Validation.Nickname.hasNumber.rawValue
        } catch ValidationError.invalidLength {
            isValidate = false
            nicknameView.invalidMessage.text = Constants.Validation.Nickname.invalidLength.rawValue
        } catch {
            isValidate = false
            nicknameView.invalidMessage.text = Constants.Validation.Nickname.etc.rawValue
        }
    }
    
    @objc private func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc private func doneButtonClicked() {
        // 유효성 검사 미통과 시 실패 처리 - 추후 수정
        if !isValidate {
            showAlert(title: "닉네임 오류",
                      message: "닉네임 입력값에 오류가 발생했어요.\n다시 확인해 주세요.",
                      type: .oneButton,
                      okHandler: nil)
            return
        }
        
        // 유효성 검사 통과 시 프로필 사진/닉네임 저장
        guard let nickname = nicknameView.nicknameField.text else { return }
        UserDefaultsManager.nickname = nickname
        UserDefaultsManager.profile = profileNum
        UserDefaultsManager.joinDate = getTodayString(formatType: "yyyy. MM. dd")
        UserDefaultsManager.like = []
        UserDefaultsManager.search = []
        UserDefaultsManager.isUser = true
    
        // rootViewController 변경
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        var rootViewController: UIViewController?
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = Resource.Colors.white
        tabBarController.tabBar.tintColor = Resource.Colors.primary
        
        let mainVC = UINavigationController(rootViewController: SearchViewController())
        let likeVC = UINavigationController(rootViewController: LikeDetailViewController())
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        
        let controllers = [mainVC, likeVC, settingVC]
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.setTabBarUI()
        
        if let items = tabBarController.tabBar.items {
            items[0].title = Constants.Tab.search.rawValue
            items[0].image = Resource.SystemImages.search
            
            items[1].title = Constants.Tab.like.rawValue
            items[1].image = Resource.SystemImages.like
            
            items[2].title = Constants.Tab.setting.rawValue
            items[2].image = Resource.SystemImages.person
        }
        
        rootViewController = tabBarController
            
        sceneDeleagate?.window?.rootViewController = rootViewController
        sceneDeleagate?.window?.makeKeyAndVisible()
    }

}
