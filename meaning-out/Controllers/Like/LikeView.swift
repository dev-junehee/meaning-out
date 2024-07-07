//
//  LikeView.swift
//  meaning-out
//
//  Created by junehee on 7/7/24.
//

import UIKit

class LikeView: BaseView {
    
    lazy var likeCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout() // 테이블뷰의 rowHeight와 같음
        
        let sectionSpaciing: CGFloat = 16
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpaciing * 2) - (cellSpacing * 2)
        layout.itemSize = CGSize(width: width/2, height: width/1.3)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
    
    override func configureViewHierarchy() {
        self.addSubview(likeCollectionView)
    }
    
    override func configureViewLayout() {
        likeCollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureViewUI() {
        // 임시
        likeCollectionView.backgroundColor = .lightGray
    }
    
}
