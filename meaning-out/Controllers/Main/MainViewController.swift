//
//  MainViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

/**
 메인 - 검색 탭
 */
class MainViewController: UIViewController {

    let searchBar = UISearchBar()
    let shoppingTableView = UITableView()
    
    let emptyView = EmptyView()
    let data: [String] = []
    
    
    
    let nickname = UserDefaultsManager.nickname

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Title.main
    }
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(shoppingTableView)
        view.addSubview(emptyView)
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(44)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        shoppingTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constants.Placeholder.searchBar.rawValue
        
        shoppingTableView.backgroundColor = .lightGray
    }

    private func test() {
        emptyView.isHidden = !data.isEmpty
        shoppingTableView.isHidden = data.isEmpty
   }
    
}
