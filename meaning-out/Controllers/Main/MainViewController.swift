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
    var searchList = UserDefaultsManager.search {
        didSet {
            shoppingTableView.reloadData()
        }
    }

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
            SearchItemHeaderTableViewCell.self,
            forCellReuseIdentifier: SearchItemHeaderTableViewCell.id
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
        UserDefaultsManager.search = ["맥북 거치대", "레오폴드 저소음 적축", "아이패드 m4 256G", "나이키 러닝화", "nike", "나잌", "뉴발란스", "카드지갑"]
        
        emptyView.isHidden = !searchList.isEmpty
        shoppingTableView.isHidden = searchList.isEmpty
   }
    
}


// MARK: MainViewContoller 익스텐션

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemHeaderTableViewCell.id) as! SearchItemHeaderTableViewCell
        
        cell.selectionStyle = .none
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAllSearchList))
        cell.removeTitle.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemTableViewCell.id, for: indexPath) as! SearchItemTableViewCell
        
        cell.selectionStyle = .none
        cell.configureCellHierarchy()
        cell.configureCellLayout()
        cell.configureCellUI()
        cell.configureCellData(data: searchList[indexPath.row])
        
        return cell
    }
    
    
    @objc func removeAllSearchList() {
        print("전체삭제 버튼 클릭")
        UserDefaultsManager.search.removeAll()
        searchList = UserDefaultsManager.search
        shoppingTableView.reloadData()
    }
}
