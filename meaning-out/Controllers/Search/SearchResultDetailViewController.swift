//
//  SearchResultDetailViewController.swift
//  meaning-out
//
//  Created by junehee on 6/18/24.
//

import UIKit

import SnapKit
import WebKit

/**
 메인 - 검색 결과 상세 화면
 */
final class SearchResultDetailViewController: BaseViewController {
    
    private let webView = WKWebView()
    var searchItem: Shopping?
    
    var likeList = UserDefaultsManager.like {
        didSet {
            configureViewController()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    override func configureViewController() {
        guard let itemTitle = searchItem?.title else { return }
        navigationItem.title = getItemTitle(itemTitle)
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(popViewController), type: .left)
        
        // UserDefaults 좋아요 상품 리스트에 해당 상품명이 있으면 like, 없으면 unlike
        let likeButton = UserDefaultsManager.like.contains(itemTitle) ? Resource.SystemImages.likeSelected : Resource.SystemImages.likeUnselected
        addImgBarBtn(image: likeButton, style: .plain, target: self, action: #selector(likeBarButtonClicked), type: .right)
    }
    
    override func configureHierarchy() {
        view.addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureData() {
        guard let itemLink = searchItem?.link else { return }
        let URL = URL(string: itemLink)!
        let request = URLRequest(url: URL)
        webView.load(request)
    }
    
    @objc private func likeBarButtonClicked() {
        // like -> unLike
        guard let itemTitle = searchItem?.title else { return }
        if likeList.contains(itemTitle) {
            likeList.append(itemTitle)
            UserDefaultsManager.like = likeList
        } else {
            guard let idx = likeList.firstIndex(of: itemTitle) else {
                print("좋아요 리스트에 해당 상품이 없어요~!")
                return
            }
            likeList.remove(at: idx)
            UserDefaultsManager.like = likeList
        }
        configureViewController()
    }

}
