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
    
    private var isDefaultSelected = true
    
    // 사용자가 선택한 프로필 이미지
//    var profileNum: Int = UserDefaultsManager.profile {
//        didSet {
//            UserDefaultsManager.profile = profileNum
//        }
//    }
    var profileNum: Int?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.inputViewWillAppear.value = ()
        profileNum = UserDefaultsManager.profile
    }
    
    private func bindData() {
        viewModel.outputProfileNum.bind { num in
            self.profileNum = num
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
        // 프로필 랜덤 노출 -> 가입 시 고정값으로 수정
        guard let profileNum = profileNum else { return }
        mainView.profileImage.image = Resource.Images.profiles[profileNum]
    }
    
}


// MARK: 익스텐션
extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Resource.Images.profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell

        let idx = indexPath.item
        let image = Resource.Images.profiles[idx]
        
        cell.configureCellHierarchy()
        cell.configureCellLayout()
        
        if idx == profileNum && isDefaultSelected {
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
        isDefaultSelected = false
        
        viewModel.inputImageSelected.value = indexPath.item
    }
}
