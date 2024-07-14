//
//  SearchResultDetailViewController.swift
//  meaning-out
//
//  Created by junehee on 6/18/24.
//

import Foundation

/**
 메인 - 검색 결과 상세 화면
 */
final class SearchResultDetailViewController: BaseViewController {

    private let mainView =  SearchResultDetailView()
    private let viewModel = SearchResultDetailViewModel()
    
    private var repository = RealmLikeItemRepository()

//    var itemId: String?
//    var itemTitle: String?
//    var itemLink: String?
    
    var item: Shopping?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaultsManager.like.removeAll())
        print(UserDefaultsManager.like)
        bindData()
        configureData()
    }
    
    private func bindData() {
        viewModel.outputLikeBarButtonClicked.bind { _ in
            self.configureViewController()
        }
    }
    
    override func configureViewController() {
        guard let item else { return }
        navigationItem.title = getItemTitle(item.title)
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(popViewController), type: .left)
        
        // 찜한 상품 리스트에 해당 상품이 있으면 like, 없으면 unlike
        let likeButton = repository.isLikeItem(id: item.productId) ? Resource.SystemImages.likeSelected : Resource.SystemImages.likeUnselected
        addImgBarBtn(image: likeButton, style: .plain, target: self, action: #selector(likeBarButtonClicked), type: .right)
        if repository.isLikeItem(id: item.productId) {
            navigationItem.rightBarButtonItem?.tintColor = Resource.Colors.primary
        }
    }
    
    private func configureData() {
        guard let item else { return }
        let URL = URL(string: item.link)!
        let request = URLRequest(url: URL)
        mainView.webView.load(request)
    }
    
    @objc private func likeBarButtonClicked() {
        print(self, #function)
        
        guard let item = item else { return }
        viewModel.inputLikeBarButtonClicked.value = item
        
        
        // like -> unLike
//        guard let itemTitle = itemTitle else { return }
//        if likeList.contains(itemTitle) {
//            likeList.append(itemTitle)
//            UserDefaultsManager.like = likeList
//        } else {
//            guard let idx = likeList.firstIndex(of: itemTitle) else {
//                print("좋아요 리스트에 해당 상품이 없어요~!")
//                return
//            }
//            likeList.remove(at: idx)
//            UserDefaultsManager.like = likeList
//        }
//        configureViewController()
    }

}
