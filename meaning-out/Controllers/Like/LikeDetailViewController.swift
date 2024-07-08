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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        likeView.likeCollectionView.delegate = self
        likeView.likeCollectionView.dataSource = self
        likeView.likeCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
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
        
        return cell
    }
}
