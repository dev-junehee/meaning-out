//
//  SettingViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    let settingTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Text.Title.setting.rawValue
    }
    
    private func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    private func configureLayout() {
        settingTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        settingTableView.backgroundColor = .white
    }

}

