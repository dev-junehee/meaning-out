//
//  ProfileImageViewController.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit
import SnapKit

class ProfileImageViewController: UIViewController {
    
    let profileImageView = UIView()
    let profileImage = UIImageView()
    
    let cameraImageView = UIView()
    let cameraImage = UIImageView()
    
    // 사용자가 선택한 프로필 이미지 (임시)
    var profileNum: Int = UserDefaults.standard.integer(forKey: Constants.Text.UserDefaults.profile.rawValue) {
        didSet {
            UserDefaults.standard.set(profileNum, forKey: Constants.Text.UserDefaults.profile.rawValue)
        }
    }
    
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionviewLayout())
    
    // 프로필 이미지 컬렉션 뷰 레이아웃 구성
    func collectionviewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpaciing: CGFloat = 16
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpaciing) - (cellSpacing)
        layout.itemSize = CGSize(width: width / 6, height: width / 6)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpaciing, left: sectionSpaciing, bottom: sectionSpaciing, right: sectionSpaciing)  // 셀과 뷰 사이 간격
        
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("이미지 설정 화면에 들어오는 값", profileNum)
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = Constants.Text.Title.profile.rawValue
        
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backButtonClicked), type: .left)
    }
    
    private func configureHierarchy() {
        cameraImageView.addSubview(cameraImage)
        
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
    
        view.addSubview(profileImageView)
        view.addSubview(profileCollectionView)
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(100)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.size.equalTo(profileImageView)
            $0.centerX.equalTo(profileImageView)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.trailing.equalTo(profileImage)
            $0.bottom.equalTo(profileImage).inset(8)
            $0.size.equalTo(24)
        }
        
        cameraImage.snp.makeConstraints {
            $0.center.equalTo(cameraImageView)
            $0.size.equalTo(15)
        }
        
        profileCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        profileImage.backgroundColor = Resource.Colors.white
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50  // 추후 상수화 하기
        profileImage.layer.borderColor = Resource.Colors.primary.cgColor
        profileImage.layer.borderWidth = CGFloat(Constants.Integer.borderWidth.rawValue)
        profileImage.contentMode = .scaleAspectFit
        
        cameraImageView.backgroundColor = Resource.Colors.primary
        cameraImageView.layer.cornerRadius = 12  // 추후 상수화 하기
        
        cameraImage.image = Resource.SystemImages.camara
        cameraImage.contentMode = .scaleAspectFit
        cameraImage.tintColor = Resource.Colors.white
    }
    
    private func configureData() {
        // 프로필 랜덤 노출 -> 가입 시 고정값으로 수정
        profileImage.image = Resource.Images.profiles[profileNum]
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
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
        profileNum == idx ? cell.configureSelectedCellUI() : cell.configureCellUI()
        cell.configureCellData(data: image)
        cell.isSelected = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("프로필 이미지를 선택했을 때", indexPath.item)
        profileNum = indexPath.item
        
        UserDefaults.standard.set(profileNum, forKey: Constants.Text.UserDefaults.profile.rawValue)
        
        print("선택한 값으로 저장한 값 맞는지 확인", UserDefaults.standard.integer(forKey: Constants.Text.UserDefaults.profile.rawValue))
        
        profileImage.image = Resource.Images.profiles[profileNum]
    }
}
