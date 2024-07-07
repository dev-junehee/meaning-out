//
//  SearchResultViewController.swift
//  meaning-out
//
//  Created by junehee on 6/17/24.
//

import UIKit

import Alamofire
import SnapKit

/**
 메인 - 검색 결과 화면
 */
class SearchResultViewController: BaseViewController {
    
    let resultView = SearchResultView()
    
    // 검색 관련 데이터
    var searchText = ""
    
    var start = 1
    var display = 30
    var nowSort = "sim"
    
    var searchTotal = 0
    var searchStart = 1
    var searchResultItem: [SearchItem] = []
    
    override func loadView() {
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest(sort: nowSort)
        configureHandler()
        configureData()
    }
    
    override func configureViewController() {
        navigationItem.title = searchText
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backButtonClicked), type: .left)
    }
    
    override func configureHierarchy() {
        resultView.resultCollectionView.delegate = self
        resultView.resultCollectionView.dataSource = self
        resultView.resultCollectionView.register(
            SearchResultCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchResultCollectionViewCell.id
        )
        resultView.resultCollectionView.prefetchDataSource = self
    }
    
    func configureData() {
        // 총 검색 결과 데이터 바인딩
        resultView.totalLabel.text = "\(searchTotal.formatted())개의 검색 결과"
    }
    
    func configureHandler() {
        resultView.simButton.addTarget(self, action: #selector(simButtonClicked), for: .touchUpInside)
        resultView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        resultView.ascButton.addTarget(self, action: #selector(ascButtonClicked), for: .touchUpInside)
        resultView.dscButton.addTarget(self, action: #selector(dscButtonClicked), for: .touchUpInside)
    }
    
    func callRequest(sort: String) {
        NetworkManager.shared.getShopping(query: searchText, start: start, sort: sort) { res in
            print(#function, res)
            
            if res.total == 0 {
                self.showAlert(title: "검색 결과가 없어요.", 
                               message: "다른 검색어를 입력해 주세요!",
                               type: .oneButton,
                               okHandler: self.alertPopViewController
                )
                return
            }
            
            if self.start == 1 {
                self.searchResultItem.removeAll()
                self.searchTotal = res.total
                self.searchResultItem = res.items
            } else {
                self.searchTotal = res.total
                self.searchResultItem.append(contentsOf: res.items)
            }
            self.configureData()
            self.resultView.resultCollectionView.reloadData()
            
            if self.start == 1 {
                self.resultView.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }


    // MARK: 버튼 핸들러
    // 뒤로가기 버튼
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    // 정확도 버튼
    @objc func simButtonClicked() {
        resultView.simButton.setClickedButtonUI()
        setUnclickedButtons(buttons: [resultView.dateButton, resultView.ascButton, resultView.dscButton])
        nowSort = Constants.Main.sortSim.rawValue
        start = 1
        callRequest(sort: Constants.Main.sortSim.rawValue)
        resultView.resultCollectionView.reloadData()
    }
    
    // 날짜순 버튼
    @objc func dateButtonClicked() {
        resultView.dateButton.setClickedButtonUI()
        setUnclickedButtons(buttons: [resultView.simButton, resultView.ascButton, resultView.dscButton])
        nowSort = Constants.Main.sortDate.rawValue
        start = 1
        callRequest(sort: Constants.Main.sortDate.rawValue)
        resultView.resultCollectionView.reloadData()
    }
    
    // 가격높은순 버튼
    @objc func ascButtonClicked() {
        resultView.ascButton.setClickedButtonUI()
        setUnclickedButtons(buttons: [resultView.simButton, resultView.dateButton, resultView.dscButton])
        nowSort = Constants.Main.sortDsc.rawValue
        start = 1
        callRequest(sort: Constants.Main.sortDsc.rawValue)
        resultView.resultCollectionView.reloadData()
    }
    
    // 가격낮은순 버튼
    @objc func dscButtonClicked() {
        resultView.dscButton.setClickedButtonUI()
        setUnclickedButtons(buttons: [resultView.simButton, resultView.dateButton, resultView.ascButton])
        nowSort = Constants.Main.sortAsc.rawValue
        start = 1
        callRequest(sort: Constants.Main.sortAsc.rawValue)
        resultView.resultCollectionView.reloadData()
    }
    
    // 검색 결과 - 좋아요 버튼 - 좋아요 저장
    @objc func likeButtonClicked(_ sender: UIButton) {
        searchResultItem[sender.tag].isLike.toggle()
        resultView.resultCollectionView.reloadItems(at: [IndexPath(row: 0, section: sender.tag)])
    }
    
}

extension SearchResultViewController {
    // 정렬 버튼 한 번에 UI 수정
    func setUnclickedButtons(buttons: [UIButton]) {
        buttons.forEach {
            $0.setUnclickedButtonUI()
        }
    }
    
    // 검색 결과 없을 때 뒤로가기
    func alertPopViewController(action: UIAlertAction) {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: SearchResultViewCotroller 익스텐션
// CollectionView
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
       
        let idx = indexPath.item
        let data = searchResultItem[idx]
        
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.configureCellData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = indexPath.item
        
        let searchResultDetailVC = SearchResultDetailViewController()
        searchResultDetailVC.searchItem = searchResultItem[item]
        navigationController?.pushViewController(searchResultDetailVC, animated: true)
    }
    
}

// Refetching (Pagenation)
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if searchResultItem.count - 2 == indexPath.item {
                start += 1
                callRequest(sort: nowSort)
            }
        }
    }
}
