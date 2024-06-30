//
//  SettingView.swift
//  meaning-out
//
//  Created by junehee on 7/1/24.
//

import UIKit
import SnapKit

class SettingView: BaseView {
    
    let tableView = UITableView()
    
    override func configureViewHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureViewLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
