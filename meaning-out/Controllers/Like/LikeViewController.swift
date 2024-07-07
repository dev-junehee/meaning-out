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
    var likeList: Results<LikeItemTable>?
    
    override func loadView() {
        self.view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeList = repository.getAllLikeItem()
        print(likeList)
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.like.rawValue
        likeView.likeCollectionView.delegate = self
        likeView.likeCollectionView.dataSource = self
        likeView.likeCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
}


extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else { return SearchResultCollectionViewCell() }
        
        return cell
    }
    
    
}
