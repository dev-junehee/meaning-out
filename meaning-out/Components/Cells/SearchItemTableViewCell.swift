//
//  SearchItemTableViewCell.swift
//  meaning-out
//
//  Created by junehee on 6/16/24.
//

import UIKit
import SnapKit

class SearchItemTableViewCell: UITableViewCell {
    
    var tableView: UITableView?

    var searchList = UserDefaultsManager.search {
        didSet {
            tableView?.reloadData()
        }
    }
    
    let clockImage = UIImageView()
    let itemLabel = UILabel()
    let xmark = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellHierarchy()
        configureCellLayout()
        configureCellUI()
        configureHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellHierarchy() {
        contentView.addSubview(clockImage)
        contentView.addSubview(itemLabel)
        contentView.addSubview(xmark)
    }
    
    func configureCellLayout() {
        clockImage.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(16)
            $0.verticalEdges.equalTo(contentView)
            $0.width.equalTo(16)
        }
        
        itemLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.leading.equalTo(clockImage.snp.trailing).offset(16)
            $0.trailing.equalTo(xmark.snp.leading)
        }
        
        xmark.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(16)
            $0.verticalEdges.equalTo(contentView)
            $0.width.equalTo(16)
        }
    }
    
    func configureCellUI() {
        clockImage.image = Resource.SystemImages.clock
        clockImage.contentMode = .scaleAspectFit
        clockImage.tintColor = Resource.Colors.black

        itemLabel.textColor = Resource.Colors.black
        itemLabel.font = Resource.Fonts.regular14
        itemLabel.textAlignment = .left
        
        xmark.setImage(Resource.SystemImages.xmark, for: .normal)
        xmark.contentMode = .scaleAspectFit
        xmark.tintColor = Resource.Colors.gray
    }
    
    func configureCellData(data: String) {
        itemLabel.text = data
    }
    
    func configureHandler() {
        xmark.addTarget(self, action: #selector(xmarkClicked), for: .touchUpInside)
    }
    
    @objc func xmarkClicked() {
        // 검색 리스트에서 해당 검색어 삭제
        print("X버튼 클릭!!!!")
        
        guard let searchText = itemLabel.text else {
            print("X버튼 클릭 오류")
            return
        }
//        let findIdx = searchList.firstIndex(of: searchText)!
//        searchList.remove(at: findIdx)
//        print(searchList)
//        UserDefaultsManager.search = searchList
        
        guard let tableView = tableView else {
            print("X버튼: 테이블뷰 오류")
            return
        }
        let findIdx = searchList.firstIndex(of: searchText)!
        searchList.remove(at: findIdx)
        print(searchList)
        UserDefaultsManager.search = searchList
        tableView.reloadData()
    }
}
