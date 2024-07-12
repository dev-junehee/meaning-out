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
final class SearchViewController: BaseViewController {

    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppearTrigger.value = () // 닉네임 바뀔 때마다 리로드
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = () // 뷰 로드될 때 searchList 가져오기
        viewToggle()
        bindData()
    }
    
    private func bindData() {
        viewModel.outputNavigationTitle.bind { title in
            self.navigationItem.title = title
        }
        viewModel.outputSearchList.bind { _ in
            self.viewToggle()
            self.mainView.shoppingTableView.reloadData()
            self.mainView.searchBar.text = ""
        }
        viewModel.outputSearchAlert.bind { title, message in
            self.showAlert(title: title, message: message, type: .oneButton, okHandler: nil)
            self.mainView.searchBar.text = ""
        }
        viewModel.outputSearchIsValid.bind { value in
            if value {
                let searchResultVC = SearchResultViewController()
                searchResultVC.searchText = self.viewModel.outputSearchList.value.first ?? ""
                self.navigationController?.pushViewController(searchResultVC, animated: true)
            }
        }
        viewModel.outputSearchListValue.bind { item in
            let searchResultVC = SearchResultViewController()
            searchResultVC.searchText = item ?? ""
            self.navigationController?.pushViewController(searchResultVC, animated: true)
        }
    }
    
    override func configureViewController() {
        mainView.searchBar.delegate = self
        
        mainView.shoppingTableView.delegate = self
        mainView.shoppingTableView.dataSource = self
        mainView.shoppingTableView.register(
            SearchItemHeaderTableViewCell.self,
            forCellReuseIdentifier: SearchItemHeaderTableViewCell.id
        )
        mainView.shoppingTableView.register(
            SearchItemTableViewCell.self,
            forCellReuseIdentifier: SearchItemTableViewCell.id
        )
        mainView.shoppingTableView.separatorStyle = .none
    }

    private func viewToggle() {
        mainView.emptyView.isHidden = !viewModel.outputSearchList.value.isEmpty
        mainView.shoppingTableView.isHidden = viewModel.outputSearchList.value.isEmpty
    }
    
    // 특정 검색어 삭제
    @objc private func removeSearchList(_ sender: UIButton) {
        viewModel.inputRemoveSearchList.value = sender.tag
    }
    
    // 검색 리스트 전체 삭제
    @objc private func removeAllSearchList() {
        viewModel.inputRemoveAllSearchList.value = ()
    }
    
}


// MARK: MainViewContoller 익스텐션
// SearchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchButtonClicked.value = searchBar.text
    }
}


// TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputSearchList.value.count
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
        cell.xmark.tag = indexPath.row
        cell.xmark.addTarget(self, action: #selector(removeSearchList(_:)), for: .touchUpInside)
        cell.configureCellData(data: viewModel.outputSearchList.value[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputSearchListClicked.value = indexPath.row
    }
    
}
