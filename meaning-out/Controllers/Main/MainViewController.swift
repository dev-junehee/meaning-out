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
    
    let nickname = UserDefaultsManager.nickname
    let searchList = UserDefaultsManager.search

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        
        // 임시
        test()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Title.main
    }
    
    private func configureHierarchy() {
        let subViews = [searchBar, shoppingTableView, emptyView]
        subViews.forEach {
            view.addSubview($0)
        }
        
        shoppingTableView.delegate = self
        shoppingTableView.dataSource = self
        shoppingTableView.register(
            SearchItemTitleTableViewCell.self,
            forCellReuseIdentifier: SearchItemTitleTableViewCell.id
        )
        shoppingTableView.register(
            SearchItemTableViewCell.self,
            forCellReuseIdentifier: SearchItemTableViewCell.id
        )
        shoppingTableView.separatorStyle = .none
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
        
        shoppingTableView.backgroundColor = .white
    }

    private func test() {
        emptyView.isHidden = !searchList.isEmpty
        shoppingTableView.isHidden = searchList.isEmpty
   }
    
}


// MARK: MainViewContoller 익스텐션

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return searchList.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemTitleTableViewCell.id, for: indexPath) as! SearchItemTitleTableViewCell
            
            cell.selectionStyle = .none
//            cell.isUserInteractionEnabled = false
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemTableViewCell.id, for: indexPath) as! SearchItemTableViewCell
            
            cell.selectionStyle = .none
            cell.configureCellHierarchy()
            cell.configureCellLayout()
            cell.configureCellUI()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        if section == 0 {
            print("전체삭제")
        } else {
            print("최근 검색들")
        }
    }
    
}
