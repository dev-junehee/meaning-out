//
//  LikeViewController.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import UIKit
import RealmSwift

class LikeViewController: BaseViewController {
    
    let likeView = LikeView()
    
    let repository = LikeItemRepository()
    var likeList: Results<LikeItemTable>? {
        didSet {
            viewToggle()
            likeView.likeCollectionView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        likeList = repository.getAllLikeItem()
        print("==========", likeList)
        viewToggle()
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.like.rawValue
        likeView.likeCollectionView.delegate = self
        likeView.likeCollectionView.dataSource = self
        likeView.likeCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    private func viewToggle() {
        guard let likeList = likeList else { return }
        likeView.emptyView.isHidden = !likeList.isEmpty
        likeView.likeCollectionView.isHidden = likeList.isEmpty
    }
    
}


extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return SearchResultCollectionViewCell() }
        
        if let likeList = likeList {
            let item = likeList[indexPath.item]
            cell.configureLikeCellData(data: item)
        }
        
        return cell
    }
    
}
