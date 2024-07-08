//
//  LikeCategoryView.swift
//  meaning-out
//
//  Created by junehee on 7/8/24.
//

import UIKit
import SnapKit

final class LikeCategoryView: BaseView {
    
    let tableView = UITableView()
    let emptyView = EmptyView()
    
    override func configureViewHierarchy() {
        self.addSubview(tableView)
        self.addSubview(emptyView)
    }
    
    override func configureViewLayout() {
        tableView.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        emptyView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
