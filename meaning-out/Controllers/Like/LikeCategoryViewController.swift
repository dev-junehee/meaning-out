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
    private var categoryList: [LikeCategory]?
    
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
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.like.rawValue
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
    
}
