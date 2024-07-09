//
//  LikeCategoryViewController.swift
//  meaning-out
//
//  Created by junehee on 7/8/24.
//

import UIKit

final class LikeCategoryViewController: BaseViewController {
    
    private let categoryView = LikeCategoryView()
    
    private let repository = RealmLikeItemRepository()
    private var categoryList: [LikeCategory]? {
        didSet {
            viewToggle()
            categoryView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.getFileURL()
        categoryList = repository.getAllLikeCategory()
        
        categoryView.tableView.delegate = self
        categoryView.tableView.dataSource = self
        categoryView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        categoryView.tableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryView.tableView.reloadData()
        viewToggle()
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.likeCategory.rawValue
        addTextBarBtn(title: Constants.Button.edit.rawValue, style: .plain, target: self, action: #selector(editButtonClicked), type: .left)
        addImgBarBtn(image: Resource.SystemImages.plus, style: .plain, target: self, action: #selector(addLikeCategoryButtonClicked), type: .right)
    }
    
    private func viewToggle() {
        guard let categoryList = categoryList else { return }
        categoryView.emptyView.isHidden = !categoryList.isEmpty
        categoryView.tableView.isHidden = categoryList.isEmpty
        
        if #available(iOS 16.0, *) {
            navigationItem.leftBarButtonItem?.isHidden = categoryList.isEmpty
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = categoryList.isEmpty
        }
    }
    
    @objc private func editButtonClicked() {
        let isEditing = !categoryView.tableView.isEditing
        categoryView.tableView.setEditing(isEditing, animated: true)
        editButtonItem.isSelected = isEditing
    }
    
    @objc private func addLikeCategoryButtonClicked() {
        showTextFieldAlert(
            title: Constants.Alert.CreateLikeCategory.title.rawValue,
            message: Constants.Alert.CreateLikeCategory.message.rawValue) { textFieldText in
            guard let textFieldText = textFieldText else { return }
            let likeCategory = LikeCategory(name: textFieldText)
            self.repository.createLikeCategory(likeCategory)
            self.categoryList = self.repository.getAllLikeCategory()
            self.categoryView.tableView.reloadData()
        }
    }
    
}

extension LikeCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "basicCell")
        
        if let categoryList = categoryList {
            cell.textLabel?.text = categoryList[indexPath.row].title
            cell.detailTextLabel?.text = "\(categoryList[indexPath.row].detailData.count)개"
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let categoryList = categoryList else { return }
        
        let category = categoryList[indexPath.row]
        if category.detailData.isEmpty {
            showAlert(
                title: Constants.Alert.EmptyLikeCategory.title.rawValue, 
                message: Constants.Alert.EmptyLikeCategory.message.rawValue, type: .oneButton) { _ in return }
        } else {
            let likeDetailVC = LikeDetailViewController()
            likeDetailVC.category = categoryList[indexPath.row]
            navigationController?.pushViewController(likeDetailVC, animated: true)
        }
    }
    
    // 찜 카테고리 밀어서 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let categoryList = self.categoryList else { return }
        let category = categoryList[indexPath.row]
        
        if category.detailData.isEmpty {
            self.repository.deleteLikeCategory(category)
        } else {
            showAlert(
                title: Constants.Alert.DeleteLikeCategory.title.rawValue,
                message: Constants.Alert.DeleteLikeCategory.message.rawValue, type: .twoButton) { _ in
                self.repository.deleteLikeCategory(category)
            }
        }
        self.categoryList = self.repository.getAllLikeCategory()
    }
}
