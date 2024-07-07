//
//  MainViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

/**
 메인 - 검색 탭
 */
class SearchViewController: BaseViewController {

    let searchView = SearchView()
    
    let nickname = UserDefaultsManager.nickname
    var searchList = UserDefaultsManager.search {
        didSet {
            viewToggle()
            searchView.shoppingTableView.reloadData()
        }
    }
    
    var start = 1
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = UserDefaultsManager.getSearchMainTitle()  // 닉네임 바뀔 때마다 리로드
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewToggle()
    }
    
    override func configureHierarchy() {
        searchView.searchBar.delegate = self
        
        searchView.shoppingTableView.delegate = self
        searchView.shoppingTableView.dataSource = self
        searchView.shoppingTableView.register(
            SearchItemHeaderTableViewCell.self,
            forCellReuseIdentifier: SearchItemHeaderTableViewCell.id
        )
        searchView.shoppingTableView.register(
            SearchItemTableViewCell.self,
            forCellReuseIdentifier: SearchItemTableViewCell.id
        )
        searchView.shoppingTableView.separatorStyle = .none
    }

    private func viewToggle() {
        searchView.emptyView.isHidden = !searchList.isEmpty
        searchView.shoppingTableView.isHidden = searchList.isEmpty
    }
    
}


// MARK: MainViewContoller 익스텐션
// SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("검색어 입력 오류")
            return
        }
        
        // 공백값 예외처리
        if searchText.trimmingCharacters(in: [" "]).count == 0 {
            showAlert(
                title: Constants.Alert.EmptyString.title.rawValue,
                message: Constants.Alert.EmptyString.message.rawValue,
                type: .oneButton,
                okHandler: nil
            )
            searchBar.text = ""
            return
        }
        
        // UserDefaults 저장
        searchList.insert(searchText, at: 0)
        UserDefaultsManager.search = searchList
        
        // 검색 결과 화면으로 push
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchText = searchText
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}


// TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemHeaderTableViewCell.id) as? SearchItemHeaderTableViewCell else { return SearchItemHeaderTableViewCell() }
        
        cell.selectionStyle = .none
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAllSearchList))
        cell.removeTitle.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemTableViewCell.id, for: indexPath) as? SearchItemTableViewCell else { return SearchItemTableViewCell() }
        
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        cell.xmark.addTarget(self, action: #selector(removeSearchList), for: .touchUpInside)
        cell.configureCellData(data: searchList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 기존 저장된 검색어
        let itemName = searchList[indexPath.row]
        // 검색 결과 화면으로 push
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchText = itemName
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
    
    // 특정 검색어 삭제
    @objc func removeSearchList(_ sender: UIButton) {
        UserDefaultsManager.search.remove(at: sender.tag)
        searchList = UserDefaultsManager.search
        searchView.shoppingTableView.reloadData()
    }
    
    // 검색 리스트 전체 삭제
    @objc func removeAllSearchList() {
        UserDefaultsManager.search.removeAll()
        searchList = UserDefaultsManager.search
        searchView.shoppingTableView.reloadData()
    }
}
