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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("SearchResultDetailViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("SearchResultDetailViewController Deinit") }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppearTrigger.value = item?.productId
    }
    
    private func bindData() {
        viewModel.outputLikeBarButtonClicked.bind { [weak self] isValid, categoryList, likeItem in
            if !isValid {
                guard let categoryList else { return }
                self?.showCategoryActionSheet(categoryList) { selected in
                    self?.viewModel.inputSelectedLikeCategory.value = (selected, likeItem)
                }
            } else {
                self?.showAlert(
                    title: Constants.Alert.DeleteLikeItem.title.rawValue,
                    message: Constants.Alert.DeleteLikeItem.message.rawValue, type: .twoButton) { _ in
                    self?.viewModel.inputDeleteLikeItem.value = likeItem
                }
            }
        }
        
        viewModel.outputLikeItemSaveDeleteReuslt.bind { [weak self] result in
            switch result {
            case .like:
                self?.navigationItem.rightBarButtonItem?.image = Resource.SystemImages.likeSelected
                self?.navigationItem.rightBarButtonItem?.tintColor = Resource.Colors.primary
            case .unlike:
                self?.navigationItem.rightBarButtonItem?.image = Resource.SystemImages.likeUnselected
            }
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
        guard let item = item else { return }
        viewModel.inputLikeBarButtonClicked.value = item
    }

}
