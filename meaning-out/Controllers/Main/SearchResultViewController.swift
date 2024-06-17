//
//  SearchResultViewController.swift
//  meaning-out
//
//  Created by junehee on 6/17/24.
//

import UIKit

import Alamofire
import SnapKit

class SearchResultViewController: UIViewController {
    
    let totalLabel = UILabel()
    
    let buttonStack = UIStackView()
    let simButton = UIButton()
    let dateButton = UIButton()
    let ascButton = UIButton()
    let dscButton = UIButton()
    
    lazy var resultCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout() // 테이블뷰의 rowHeight와 같음
        
        let sectionSpaciing: CGFloat = 16
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpaciing * 2) - (cellSpacing * 2)
        layout.itemSize = CGSize(width: width/2, height: width/1.3)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing

        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
    
    // 검색 관련 데이터
    var searchText = ""
    
    var start = 1
    var display = 30
    var sort = "sim"
    
    var searchResult: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureData()
        configureHandler()
        callRequest()
    }
    
    private func configureView() {
        view.backgroundColor = Resource.Colors.white
        navigationItem.title = searchText
        
        addImgBarBtn(image: Resource.SystemImages.left, style: .plain, target: self, action: #selector(backButtonClicked), type: .left)
    }
    
    private func configureHierarchy() {
        let buttonViews = [simButton, dateButton, ascButton, dscButton]
        buttonViews.forEach {
            buttonStack.addArrangedSubview($0)
        }
        
        let subviews = [totalLabel, buttonStack, resultCollectionView]
        subviews.forEach {
            view.addSubview($0)
        }
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.register(
            SearchResultCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchResultCollectionViewCell.id
        )
    }
    
    private func configureLayout() {
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(30)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(40)
        }
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 8
        
        let simDateButton = [simButton, dateButton]
        simDateButton.forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(70)
            }
        }
        
        let priceButton = [ascButton, dscButton]
        priceButton.forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(90)
            }
        }
        
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        totalLabel.font = Resource.Fonts.bold14
        totalLabel.textColor = Resource.Colors.primary
        
        let buttons = [simButton, dateButton, ascButton, dscButton]
        let titles = Constants.Button.sorting
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            let title = titles[i]
            
            button.setTitle(title, for: .normal)
            button.setTitleColor(Resource.Colors.black, for: .normal)
            button.titleLabel?.font = Resource.Fonts.bold15
            button.layer.borderColor = Resource.Colors.gray.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 20
        }
        
        // 정확도 버튼 선택된 상태 기본 세팅
        setClickedButtonUI(simButton)
        setUnclickedButtonUI([dateButton, ascButton, dscButton])
    }
    
    func configureData() {
        // 임시 데이터
        totalLabel.text = "\(235499.formatted())개의 검색 결과"
    }
    
    func configureHandler() {
        simButton.addTarget(self, action: #selector(simButtonClicked), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        ascButton.addTarget(self, action: #selector(ascButtonClicked), for: .touchUpInside)
        dscButton.addTarget(self, action: #selector(dscButtonClicked), for: .touchUpInside)
    }
    
    func callRequest() {
        let headers: HTTPHeaders = [
            API.Shopping.ID_KEY_NAME: API.Shopping.ID_KEY,
            API.Shopping.SECRET_KEY_NAME: API.Shopping.SECRET_KEY
        ]

        let URL = "\(API.Shopping.URL)query=\(searchText)&start=\(start)&display=\(display)&sort=\(sort)"

        AF.request(URL, method: .get, headers: headers)
            .responseDecodable(of: SearchResult.self) { res in
            switch res.result {
            case .success(let value):
                print(value)
                self.searchResult = value
            case .failure(let error):
                print(error)
            }
        }
    }
    

    // MARK: 버튼 핸들러
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func simButtonClicked() {
        // 정확도 순서로 정렬 (기본)
        print("정확도 클릭")
        setClickedButtonUI(simButton)
        setUnclickedButtonUI([dateButton, ascButton, dscButton])
    }
    
    @objc func dateButtonClicked() {
        // 정확도 순서로 정렬 (기본)
        print("날짜순 순서 클릭")
        setClickedButtonUI(dateButton)
        setUnclickedButtonUI([simButton, ascButton, dscButton])
    }
    
    @objc func ascButtonClicked() {
        // 정확도 순서로 정렬 (기본)
        print("가격높은순 클릭")
        setClickedButtonUI(ascButton)
        setUnclickedButtonUI([simButton, dateButton, dscButton])
    }
    
    @objc func dscButtonClicked() {
        // 정확도 순서로 정렬 (기본)
        print("가격 낮은순 클릭")
        setClickedButtonUI(dscButton)
        setUnclickedButtonUI([simButton, dateButton, ascButton])
    }
    
}


// MARK: SearchResultViewCotroller 익스텐션
// CollectionView
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 임시
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
        
        return cell
    }
    
    
}
