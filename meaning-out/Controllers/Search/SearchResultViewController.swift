//
//  SearchResultViewController.swift
//  meaning-out
//
//  Created by junehee on 6/17/24.
//

import UIKit

enum SortType: String {
    case sim
    case date
    case asc
    case dsc
}

/**
 메인 - 검색 결과 화면
 */
final class SearchResultViewController: BaseViewController {

    private let mainView = SearchResultView()
    private let viewModel = SearchResultViewModel()
    private let repository = RealmLikeItemRepository()
    
    // 검색 관련 데이터
    var searchText = ""
    var start = 1
    var nowSort: SortType = .sim

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        viewModel.inputCallRequest.value = (query: searchText, start: start, sort: nowSort)
        
        configureHandler()
        configureData()
    }
    
    private func bindData() {
        viewModel.outputNoResultAlert.bind { title, message in
            self.showAlert(title: title, message: message, type: .oneButton, okHandler: self.alertPopViewController(action:))
        }
        
        viewModel.outputShoppingResultIsValid.bind { isValid in
            if isValid {
                self.configureData()
                self.mainView.resultCollectionView.reloadData()
            }
            if self.start == 1 {
                self.mainView.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    override func configureViewController() {
        navigationItem.title = searchText
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(popViewController), type: .left)
    }
    
    override func configureHierarchy() {
        mainView.resultCollectionView.delegate = self
        mainView.resultCollectionView.dataSource = self
        mainView.resultCollectionView.register(
            SearchResultCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchResultCollectionViewCell.id
        )
        mainView.resultCollectionView.prefetchDataSource = self
    }
    
    private func configureData() {
        // 총 검색 결과 데이터 바인딩
        mainView.totalLabel.text = "\(viewModel.outputShoppingTotal.value.formatted())개의 검색 결과"
    }
    
    private func configureHandler() {
        let buttons = [mainView.simButton, mainView.dateButton, mainView.ascButton, mainView.dscButton]
        buttons.forEach {
            $0.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        }
    }

    // MARK: 버튼 핸들러
    @objc private func sortButtonClicked(_ sender: UIButton) {
        setSorting(tag: sender.tag)
        start = 1
        viewModel.inputCallRequest.value = (query: searchText, start: start, sort: nowSort)
    }

    // 검색 결과 - 좋아요 버튼 - 좋아요 저장
    @objc func likeButtonClicked(_ sender: UIButton) {
        let id = viewModel.outputShoppingResult.value[sender.tag].productId
        
        
        if !repository.isLikeItem(id: id) {
            // 찜 안했을 때 - 찜 하기
            let likeItem = LikeItem(item: viewModel.outputShoppingResult.value[sender.tag])
            showCategoryActionSheet(repository.getAllLikeCategory()) { selected in
                guard let selected else { return print("선택한 카테고리 없음") }
                if let category = self.repository.findLikeCategory(title: selected) {
                    self.repository.createLikeItem(likeItem, category: category)
                    self.mainView.resultCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
                }
            }
        } else {
            // 찜했을 때 - 찜 취소
            showAlert(title: "찜을 해제할까요?", message: "해당 상품이 찜에서 사라져요!", type: .twoButton) { _ in
                let item = self.viewModel.outputShoppingResult.value[sender.tag]
                let target = self.repository.findLikeItem(id: item.productId)
                if let target {
                    self.repository.deleteLikeItem(item: target)
                    self.mainView.resultCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
                }
            }
        }
    }
    
}

extension SearchResultViewController {
    // 정렬 버튼 한 번에 UI 수정
    private func setUnclickedButtons(buttons: [UIButton]) {
        buttons.forEach {
            $0.setUnclickedButtonUI()
        }
    }
    
    // 정렬 타입 설정
    private func setSorting(tag: Int) {
        if tag == 0 {
            mainView.simButton.setClickedButtonUI()
            setUnclickedButtons(buttons: [mainView.dateButton, mainView.ascButton, mainView.dscButton])
            nowSort = .sim
        } else if tag == 1 {
            mainView.dateButton.setClickedButtonUI()
            setUnclickedButtons(buttons: [mainView.simButton, mainView.ascButton, mainView.dscButton])
            nowSort = .date
        } else if tag == 2 {
            mainView.ascButton.setClickedButtonUI()
            setUnclickedButtons(buttons: [mainView.simButton, mainView.dateButton, mainView.dscButton])
            nowSort = .asc
        } else {
            mainView.dscButton.setClickedButtonUI()
            setUnclickedButtons(buttons: [mainView.simButton, mainView.dateButton, mainView.ascButton])
            nowSort = .dsc
        }
    }
    
    // 검색 결과 없을 때 뒤로가기
    private func alertPopViewController(action: UIAlertAction) {
        navigationController?.popViewController(animated: true)
    }
    
    // 찜 상품 저장 시 카테고리 선택창
    private func showCategoryActionSheet(_ actionList: [LikeCategory], completion: ((String?) -> Void)?) {
        let alert = UIAlertController(
            title: Constants.Alert.SelectLikeCategory.title.rawValue,
            message: nil,
            preferredStyle: .actionSheet)
        
        actionList.forEach {
            alert.addAction(UIAlertAction(title: $0.title, style: .default, handler: { action in
                completion?(action.title)
            }))
        }
        
        let cancel = UIAlertAction(title: Constants.Button.cancel.rawValue, style: .cancel)
        alert.addAction(cancel)

        present(alert, animated: true)
    }
    
}


// MARK: SearchResultViewCotroller 익스텐션
// CollectionView
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputShoppingResult.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return SearchResultCollectionViewCell() }
       
        let idx = indexPath.item
        let data = viewModel.outputShoppingResult.value[idx]
        
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.configureCellData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.outputShoppingResult.value[indexPath.item]
        let searchResultDetailVC = SearchResultDetailViewController()
        searchResultDetailVC.itemId = item.productId
        searchResultDetailVC.itemTitle = item.title
        searchResultDetailVC.itemLink = item.link
        navigationController?.pushViewController(searchResultDetailVC, animated: true)
    }
    
}

// Refetching (Pagenation)
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.outputShoppingResult.value.count - 2 == indexPath.item {
                start += 1
                viewModel.inputCallRequest.value = (query: searchText, start: start, sort: nowSort)
            }
        }
    }
}
