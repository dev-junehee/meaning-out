//
//  LikeViewController.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import UIKit
import RealmSwift

final class LikeDetailViewController: BaseViewController {
    
    private let likeView = LikeDetailView()
    
    private let repository = RealmLikeItemRepository()
    var category: LikeCategory?

    override func loadView() {
        self.view = likeView
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(category?.detailData)
//    }
    
    override func configureViewController() {
        setNavigationItemTitle()
        setTableViewDelegate()
    }
    
    private func setNavigationItemTitle() {
        navigationItem.title = category?.title
        navigationController?.navigationBar.tintColor = Resource.Colors.primary
    }
    
    private func setTableViewDelegate() {
        likeView.likeCollectionView.delegate = self
        likeView.likeCollectionView.dataSource = self
        likeView.likeCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    // 찜 버튼 클릭하면 찜 해제 처리
    @objc private func likeButtonClicked(_ sender: UIButton) {
        showAlert(title: "찜을 해제할까요?", message: "해당 상품이 찜에서 사라져요!", type: .twoButton) { _ in
            if let category = self.repository.findLikeCategory(title: self.navigationItem.title ?? "") {
                self.repository.deleteLikeItem(item: category.detailData[sender.tag], category: category, at: sender.tag)
                if category.detailData.isEmpty {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.likeView.likeCollectionView.reloadData()
                }
            }
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
        
        
    }
}
