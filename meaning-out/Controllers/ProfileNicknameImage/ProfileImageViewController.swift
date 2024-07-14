//
//  ProfileImageViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

final class ProfileImageViewController: BaseViewController {
    
    private let mainView = ProfileImageView()
    private let viewModel = ProfileImageViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppear.value = ()
    }
    
    private func bindData() {
        viewModel.outputProfileNum.bind { _ in
            self.configureData()
        }
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.profile.rawValue
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector( popViewController), type: .left)
    }
    
    override func configureHierarchy() {
        mainView.profileCollectionView.delegate = self
        mainView.profileCollectionView.dataSource = self
        mainView.profileCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }

    private func configureData() {
        let profileNum = viewModel.outputProfileNum.value
        mainView.profileImage.image = Resource.Images.profiles[profileNum]
    }
    
}


// MARK: CollectionView Extension
extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Resource.Images.profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return ProfileImageCollectionViewCell() }

        let idx = indexPath.item
        let image = Resource.Images.profiles[idx]
        
        if idx == viewModel.outputProfileNum.value {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
            cell.configureSelectedCellUI()
        }
        cell.configureCellData(data: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputImageSelected.value = indexPath.item
    }
}
