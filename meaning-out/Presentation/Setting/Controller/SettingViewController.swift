//
//  SettingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

/**
 메인 - 설정 탭
 */
final class SettingViewController: BaseViewController {
    
    private let mainView = SettingView()
    private let viewModel = SettingViewModel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("SettingViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("SettingViewController Deinit") }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    private func bindData() {
        viewModel.outputNickname.bind { [weak self] _ in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.outputCancelationIsSucceed.bind { [weak self] _ in
            self?.changeRootViewControllerToOnboarding()
        }
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.setting.rawValue
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SettingProfileTableViewCell.self, forCellReuseIdentifier: SettingProfileTableViewCell.id)
        mainView.tableView.register(SettingMenuTableViewCell.self, forCellReuseIdentifier: SettingMenuTableViewCell.id)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.id, for: indexPath) as? SettingProfileTableViewCell else { return SettingProfileTableViewCell() }
 
            cell.configureCellData()
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingMenuTableViewCell.id, for: indexPath) as? SettingMenuTableViewCell else { return SettingMenuTableViewCell() }
            
            let menu = Constants.SettingOptions.allCases[section].menuOptions[idx]
          
            if indexPath.row == 0 {
                cell.configureLikeCellData(data: menu)
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
        
        if row == 0 {
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 1  // 찜 탭으로 연결
            }
            return
        }
        
        if row == 4 {
            showAlert(
                title: Constants.Alert.Cancelation.title.rawValue,
                message: Constants.Alert.Cancelation.message.rawValue,
                type: .twoButton,
                okHandler: alertOkayClicked
            )
        }
    }
}


// MARK: Alert Action 알럿 액션 함수
extension SettingViewController {
    func alertOkayClicked(action: UIAlertAction) {
        viewModel.inputCancelationAlert.value = ()
    }
}
