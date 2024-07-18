//
//  LikeViewController.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import UIKit

final class LikeDetailViewController: BaseViewController {
    
    private let mainView = LikeDetailView()
    private let viewModel = LikeDetailViewModel()
    
    var category: LikeCategory?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("LikeDetailViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("LikeDetailViewController Deinit") }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewAppearTrigger.value = category?.detailData.count
    }
    
    private func bindData() {
        viewModel.outputCategoryDataIsEmpty.bind { isEmpty in
            if isEmpty {
                self.mainView.likeCollectionView.reloadData()
                self.showAlert(
                    title: Constants.Alert.EmptyLikeCategory.title.rawValue,
                    message: Constants.Alert.EmptyLikeCategory.message.rawValue, 
                    type: .oneButton) { _ in
                        self.popViewController()
                    }
            } else {
                self.mainView.likeCollectionView.reloadData()
            }
        }
    }
    
    override func configureViewController() {
        setNavigationItemTitle()
        setTableViewDelegate()
    }
    
    private func setNavigationItemTitle() {
        navigationItem.title = category?.title
        navigationController?.navigationBar.tintColor = Resource.Colors.primary
    }
    
    private func setTableViewDelegate() {
        mainView.likeCollectionView.delegate = self
        mainView.likeCollectionView.dataSource = self
        mainView.likeCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    // 찜 버튼 클릭하면 찜 해제 처리
    @objc private func likeButtonClicked(_ sender: UIButton) {
        showAlert(title: "찜을 해제할까요?", message: "해당 상품이 찜에서 사라져요!", type: .twoButton) { _ in
            self.viewModel.inputDeleteLikeItem.value = (title: self.navigationItem.title, tag: sender.tag)
        }
    }
}


extension LikeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.detailData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return SearchResultCollectionViewCell() }
        
        if let likeList = category?.detailData {
            let item = likeList[indexPath.item]
            cell.configureLikeCellData(data: item)
        }
        
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀 클릭하면 상품 상세화면으로 이동
        guard let item = category?.detailData[indexPath.item] else { return }
        let searchResultDetailVC = SearchResultDetailViewController()
//        searchResultDetailVC.itemId = item.id
//        searchResultDetailVC.itemTitle = item.title
//        searchResultDetailVC.itemLink = item.link
        navigationController?.pushViewController(searchResultDetailVC, animated: true)
    }
    
}
