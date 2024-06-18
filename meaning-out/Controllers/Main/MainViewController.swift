//
//  MainViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

import Alamofire
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
            viewToggle()
            shoppingTableView.reloadData()
        }
    }
    
    var start = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        viewToggle()
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
        
        searchBar.delegate = self
        
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

    private func viewToggle() {
        emptyView.isHidden = !searchList.isEmpty
        shoppingTableView.isHidden = searchList.isEmpty
   }
    
}


// MARK: MainViewContoller 익스텐션
// SearchBar
extension MainViewController: UISearchBarDelegate {
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
                okHandler: nil,
                cancelHandler: nil
            )
            searchBar.text = ""
            return
        }
        
        // UserDefaults 저장
        searchList.insert(searchText, at: 0)
        UserDefaultsManager.search = searchList
        print(UserDefaultsManager.search)
        
        // 검색 결과 화면으로 push
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchText = searchText
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}


// TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 기존 저장된 검색어
        let itemName = searchList[indexPath.row]
        // 검색 결과 화면으로 push
        let searchResultVC = SearchResultViewController()
        searchResultVC.searchText = itemName
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
    
    
    @objc func removeAllSearchList() {
        // 전체 삭제 버튼 핸들러
        UserDefaultsManager.search.removeAll()
        searchList = UserDefaultsManager.search
        shoppingTableView.reloadData()
    }
}
