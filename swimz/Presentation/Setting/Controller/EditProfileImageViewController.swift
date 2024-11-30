//
//  EditProfileImageViewController.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit

final class EditProfileImageViewController: BaseViewController {
    
    private let editProfileImageView = ProfileImageView()
    private let viewModel = EditProfileImageViewModel()
    
    // 사용자가 선택한 프로필 이미지
    var profileNum: Int = UserDefaultsManager.profile
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("EditProfileImageViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("EditProfileImageViewController Deinit") }
    
    override func loadView() {
        self.view = editProfileImageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        bindData()
    }
    
    private func bindData() {
        viewModel.outputProfileNum.bind { [weak self] num in
            self?.profileNum = num
            self?.editProfileImageView.profileImage.image = Resource.Images.profiles[num]
        }
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.edit.rawValue
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(popViewController), type: .left)
        
        editProfileImageView.profileCollectionView.delegate = self
        editProfileImageView.profileCollectionView.dataSource = self
        editProfileImageView.profileCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
    
    private func configureData() {
        // 프로필 랜덤 노출 -> 가입 시 고정값으로 수정
        editProfileImageView.profileImage.image = Resource.Images.profiles[profileNum]
    }

}


// MARK: EditProfileViewController 익스텐션
extension EditProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Resource.Images.profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return ProfileImageCollectionViewCell() }

        let idx = indexPath.item
        let image = Resource.Images.profiles[idx]
        
        if idx == profileNum {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            cell.configureSelectedCellUI()
        } else {
            cell.configureCellUI()
        }
        
        cell.configureCellData(data: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputProfileNum.value = indexPath.item
    }
}
