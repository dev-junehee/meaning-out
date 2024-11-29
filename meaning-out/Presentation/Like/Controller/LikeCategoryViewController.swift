//
//  LikeCategoryViewController.swift
//  meaning-out
//
//  Created by junehee on 7/8/24.
//

import UIKit

final class LikeCategoryViewController: BaseViewController {
    
    private let mainView = LikeCategoryView()
    private let viewModel = LikeCategoryViewModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("LikeCategoryViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("LikeCategoryViewController Deinit") }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
        viewToggle()
    }
    
    private func bindData() {
        viewModel.outputAllLikeCategory.bind { [weak self] _ in
            self?.mainView.tableView.reloadData()
            self?.viewToggle()
        }
        
        viewModel.outputAddLikeCetagoryButton.bind { [weak self] _ in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.outputDeleteLikeCategoryIsSucceed.bind { [weak self] _ in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.outputDeleteLikeCategoryAlert.bind { [weak self] title, message, category in
            guard let category = category else { return }
            self?.showAlert(title: title, message: message, type: .twoButton) { _ in
                self?.viewModel.inputDeleteLikeCategoryAlertOkay.value = category
            }
        }
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.likeCategory.rawValue
        
        addTextBarBtn(title: Constants.Button.edit.rawValue, style: .plain, target: self, action: #selector(editButtonClicked), type: .left)
        addImgBarBtn(image: Resource.SystemImages.plus, style: .plain, target: self, action: #selector(addLikeCategoryButtonClicked), type: .right)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        mainView.tableView.rowHeight = 60
    }
    
    private func viewToggle() {
        let categoryList = viewModel.outputAllLikeCategory.value
        mainView.emptyView.isHidden = !categoryList.isEmpty
        mainView.tableView.isHidden = categoryList.isEmpty
        
        // 찜 카테고리 없을 때 Edit 버튼 숨기고, 편집 모드 해지
        if #available(iOS 16.0, *) {
            navigationItem.leftBarButtonItem?.isHidden = categoryList.isEmpty
            mainView.tableView.isEditing = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = categoryList.isEmpty
            mainView.tableView.isEditing = false
        }
    }
    
    @objc private func editButtonClicked() {
        let isEditing = !mainView.tableView.isEditing
        mainView.tableView.setEditing(isEditing, animated: true)
        editButtonItem.isSelected = isEditing
    }
    
    @objc private func addLikeCategoryButtonClicked() {
        showTextFieldAlert(
            title: Constants.Alert.CreateLikeCategory.title.rawValue,
            message: Constants.Alert.CreateLikeCategory.message.rawValue,
            placeholder: Constants.Like.placeholder.rawValue) { textFieldText in
                self.viewModel.inputAddLikeCategoryButtonClicked.value = textFieldText
        }
    }
    
}

extension LikeCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputAllLikeCategory.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Like.baseCellId.rawValue, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.Like.baseCellId.rawValue)

        cell.textLabel?.text = viewModel.outputAllLikeCategory.value[indexPath.row].title
        cell.detailTextLabel?.text = "\(viewModel.outputAllLikeCategory.value[indexPath.row].detailData.count)개"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel.outputAllLikeCategory.value[indexPath.row]
        if category.detailData.isEmpty {
            showAlert(
                title: Constants.Alert.EmptyLikeCategory.title.rawValue, 
                message: Constants.Alert.EmptyLikeCategory.message.rawValue, type: .oneButton) { _ in return }
        } else {
            let likeDetailVC = LikeDetailViewController()
            likeDetailVC.category = category
            navigationController?.pushViewController(likeDetailVC, animated: true)
        }
    }
    
    // 찜 카테고리 밀어서 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.inputDeleteLikeCategory.value = indexPath.row
    }
}
