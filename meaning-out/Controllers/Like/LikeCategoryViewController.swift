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
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.likeCategory.rawValue
        addTextBarBtn(title: "Edit", style: .plain, target: self, action: #selector(editButtonClicked), type: .left)
        addImgBarBtn(image: Resource.SystemImages.plus, style: .plain, target: self, action: #selector(addLikeCategoryButtonClicked), type: .right)
    }
    
    @objc private func editButtonClicked() {
        let isEditing = !categoryView.tableView.isEditing
        categoryView.tableView.setEditing(isEditing, animated: true)
        editButtonItem.isSelected = isEditing
    }
    
    @objc private func addLikeCategoryButtonClicked() {
        showTextFieldAlert(
            title: Constants.Alert.createLikeCategory.title.rawValue,
            message: Constants.Alert.createLikeCategory.message.rawValue) { textFieldText in
            guard let textFieldText = textFieldText else { return }
            let likeCategory = LikeCategory(name: textFieldText)
            self.repository.createLikeCategory(likeCategory)
            self.categoryList = self.repository.getAllLikeCategory()
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
        let likeDetailVC = LikeDetailViewController()
        guard let categoryList = categoryList else { return }
        likeDetailVC.category = categoryList[indexPath.row]
        navigationController?.pushViewController(likeDetailVC, animated: true)
    }
    
    // 찜 카테고리 밀어서 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        showAlert(title: "찜 카테고리 삭제", message: "카테고리에 포함된 모든 찜 상품도 함께 삭제됩니다.", type: .twoButton) { _ in
            guard let categoryList = self.categoryList else { return }
            let category = categoryList[indexPath.row]
            self.repository.deleteLikeCategory(category)
            self.categoryList = self.repository.getAllLikeCategory()
        }
    }
}
