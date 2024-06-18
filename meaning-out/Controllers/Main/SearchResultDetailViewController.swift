//
//  SearchResultDetailViewController.swift
//  meaning-out
//
//  Created by junehee on 6/18/24.
//

import UIKit

import SnapKit
import WebKit

class SearchResultDetailViewController: UIViewController {
    
    let webView = WKWebView()
    
    var itemTitle: String = ""
    var itemLink: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(itemTitle)
        print(itemLink)
        configureView()
        configureHierarchy()
        configureLayout()
        configureData()
    }
    
    func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = itemTitle
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backBarButtonclicked), type: .left)
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

}
