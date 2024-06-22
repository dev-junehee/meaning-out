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
class SearchResultDetailViewController: UIViewController {
    
    let webView = WKWebView()
    
    var itemTitle: String = ""
    var itemLink: String = ""
    var itemIsLike: Bool = false
    
    var cartList = UserDefaultsManager.cart {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
        configureData()
    }
    
    func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = getItemTitle(itemTitle)
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backBarButtonclicked), type: .left)
        
        // UserDefaults 좋아요 상품 리스트에 해당 상품명이 있으면 like, 없으면 unlike
        let likeButton = UserDefaultsManager.cart.contains(itemTitle) ? Resource.Images.likeSelected : Resource.Images.likeUnselected
        addImgBarBtn(image: likeButton, style: .plain, target: self, action: #selector(likeBarButtonClicked), type: .right)
    }
    
    func configureHierarchy() {
        view.addSubview(webView)
    }
    
    func configureLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureData() {
        let URL = URL(string: itemLink)!
        let request = URLRequest(url: URL)
        webView.load(request)
    }
    
    @objc func backBarButtonclicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func likeBarButtonClicked() {
        // like -> unLike
        if cartList.contains(itemTitle) {
            cartList.append(itemTitle)
            UserDefaultsManager.cart = cartList
        } else {
            guard let idx = cartList.firstIndex(of: itemTitle) else {
                print("좋아요 리스트에 해당 상품이 없어요~!")
                return
            }
            cartList.remove(at: idx)
            UserDefaultsManager.cart = cartList
        }
        configureView()
    }

}
