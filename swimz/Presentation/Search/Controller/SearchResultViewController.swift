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
    
    // 검색 관련 데이터
    var searchText = ""
    var start = 1
    var nowSort: SortType = .sim

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("SearchResultViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("SearchResultViewController Deinit") }
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.resultCollectionView.reloadData()
    }
    
    private func bindData() {
        viewModel.outputShoppingResponse.bind { [weak self] res in
            switch res {
            case .success:
                self?.configureData()
                self?.mainView.resultCollectionView.reloadData()
                if self?.start == 1 {
                    self?.mainView.resultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
            case .noResult:
                self?.showAlert(
                    title: Constants.Alert.NoSearchResult.title.rawValue,
                    message: Constants.Alert.NoSearchResult.message.rawValue,
                    type: .oneButton) { _ in
                        self?.popViewController()
                    }
            case .fail:
                self?.showAlert(
                    title: Constants.Alert.FailSearch.title.rawValue,
                    message: Constants.Alert.FailSearch.message.rawValue,
                    type: .oneButton) { _ in
                        self?.popViewController()
                    }
            }
        }
        
        viewModel.outputTransitionToDetail.bind { [weak self] item in
            let searchResultDetailVC = SearchResultDetailViewController()
            searchResultDetailVC.item = item
            self?.navigationController?.pushViewController(searchResultDetailVC, animated: true)
        }
        
        viewModel.outputLikeItemIsValid.bind { [weak self] isValid, categoryList, likeItem in
            if !isValid {
                guard let categoryList else { return }
                self?.showCategoryActionSheet(categoryList) { selected in
                    self?.viewModel.inputSelectedLikeCategory.value = (selected, likeItem)
                }
            } else {
                self?.showAlert(
                    title: Constants.Alert.DeleteLikeItem.title.rawValue,
                    message: Constants.Alert.DeleteLikeItem.message.rawValue, type: .twoButton) { _ in
                    self?.viewModel.inputDeleteLikeItem.value = likeItem
                }
            }
        }
        
        viewModel.outputSaveDeleteLikeItemIsSucceed.bind { [weak self] isSucceed in
            if isSucceed {
                self?.mainView.resultCollectionView.reloadData()
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
        mainView.totalLabel.text = "\(viewModel.outputShoppingResult.value.total.formatted())개의 검색 결과"
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
        viewModel.inputSearchItemLikeButtonClicked.value = sender.tag
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
    
}


// MARK: SearchResultViewCotroller 익스텐션
// CollectionView
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputShoppingResult.value.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return SearchResultCollectionViewCell() }
       
        let idx = indexPath.item
        let item = viewModel.outputShoppingResult.value.items[idx]
        
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.configureCellData(data: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputSearchItemClicked.value = indexPath.item
    }
    
}

// Refetching (Pagenation)
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.outputShoppingResult.value.items.count - 2 == indexPath.item {
                start += 1
                viewModel.inputCallRequest.value = (query: searchText, start: start, sort: nowSort)
            }
        }
    }
}
