//
//  SearchView.swift
//  meaning-out
//
//  Created by junehee on 6/30/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchBar = UISearchBar()
    let shoppingTableView = UITableView()
    
    let emptyView = EmptyView()
    
    override func configureViewHierarchy() {
        let subViews = [searchBar, shoppingTableView, emptyView]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(44)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        shoppingTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constants.Placeholder.searchBar.rawValue
        emptyView.emptyText = Constants.Search.empty.rawValue
    }
    
}
