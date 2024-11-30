//
//  SearchResultDetailView.swift
//  meaning-out
//
//  Created by junehee on 7/14/24.
//

import WebKit
import SnapKit

final class SearchResultDetailView: BaseView {
    
    let webView = WKWebView()
    
    override func configureViewHierarchy() {
        self.addSubview(webView)
    }
    
    override func configureViewLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
