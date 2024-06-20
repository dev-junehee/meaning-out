//
//  SettingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

/**
 메인 - 설정 탭
 */
class SettingViewController: UIViewController {
    
    let settingTableView = UITableView()
    
    var nickname = UserDefaultsManager.nickname {
        didSet {
            settingTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nickname = UserDefaultsManager.nickname
        settingTableView.reloadData()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Title.setting.rawValue
    }
    
    private func configureHierarchy() {
        view.addSubview(settingTableView)
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingProfileTableViewCell.self, forCellReuseIdentifier: SettingProfileTableViewCell.id)
        settingTableView.register(SettingMenuTableViewCell.self, forCellReuseIdentifier: SettingMenuTableViewCell.id)
    }
    
    private func configureLayout() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


// MARK: SettingViewController 익스텐션
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.SettingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return Constants.SettingOptions.allCases[section].menuOptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let idx = indexPath.row
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.id, for: indexPath) as! SettingProfileTableViewCell
 
            cell.configureCellData()
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingMenuTableViewCell.id, for: indexPath) as! SettingMenuTableViewCell
            
            let menu = Constants.SettingOptions.allCases[section].menuOptions[idx]
          
            if indexPath.row == 0 {
                cell.configureCartCellData(data: menu)
            } else {
                cell.configureCellData(data: menu)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            let editNicknameVC = EditNicknameViewController()
            navigationController?.pushViewController(editNicknameVC, animated: true)
            return
        }
        
        if row == 4 {
            showAlert(
                title: Constants.Alert.Cancelation.title.rawValue,
                message: Constants.Alert.Cancelation.message.rawValue,
                type: .twoButton,
                okHandler: alertOkayClicked,
                cancelHandler: alertCancelClicked
            )
        }
    }
    
}


// MARK: Alert Action 알럿 액션 함수
extension SettingViewController {
    func alertOkayClicked(action: UIAlertAction) {
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
    
    func alertCancelClicked(action: UIAlertAction) {
        return
    }
}
