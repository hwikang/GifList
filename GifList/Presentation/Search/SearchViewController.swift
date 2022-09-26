//
//  SearchViewController.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import UIKit
import RxSwift
import RxRelay

class SearchViewController: UIViewController {

    private var disposeBag = DisposeBag()
    private var searchText = PublishRelay<String>()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: Strings.searchTabTitle.rawValue, at: 0, animated: true)
        control.insertSegment(withTitle: Strings.searchSetting.rawValue, at: 1, animated: true)
        
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)
        
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)
        control.selectedSegmentIndex = 0
        return control
    }()
    
    lazy var searchView: SearchView = {
        
        let view = SearchView()
        view.searchDataDelegate = self
        return view
    }()
    
    
    lazy var settingView: SettingView = {
        let view = SettingView()
        return view
    }()
    
    private let searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindView()
        bindViewModel()
    }
    
    
    private func setUI() {
        
        self.view.addSubview(segmentedControl)
        self.view.addSubview(searchView)
        self.view.addSubview(settingView)

        setConstraint()
    }
    private func setConstraint() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(ComponentSize.searchViewSegmentControlWidth)
            make.height.equalTo(ComponentSize.searchViewSegmentControlHeight)
        }
        setContentViewConstraint(view: searchView)
        setContentViewConstraint(view: settingView)
    }
    private func setContentViewConstraint(view: UIView) {
        view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(ComponentSize.searchViewTopPadding)
            make.left.equalTo(ComponentSize.searchViewLeftPadding)
            make.right.equalTo(ComponentSize.searchViewRightPadding)
            make.bottom.equalToSuperview()
        }
    }
    
    private func bindView() {
        searchView.textField.rx.text.bind { [weak self] text in
            if let text = text {
                self?.searchText.accept(text)
            }
        }.disposed(by: disposeBag)
        
        settingView.numberOfColumnsObservable().bind { [weak self] numberOfColumns in
            guard let self = self else { return }
            self.searchView.setColumnCount(numberOfColumns)
            self.searchView.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = SearchViewModel.Input(segmentedControlIndex: self.segmentedControl.rx.selectedSegmentIndex.asDriver(),searchText: searchText.asDriver(onErrorJustReturn: ""))
      
        let output = searchViewModel.transform(input: input)
        output.segmentIndex.bind {[weak self] index in
            
            if index == 0 {
                self?.searchView.isHidden = false
                self?.settingView.isHidden = true
            }else {
                self?.searchView.isHidden = true
                self?.settingView.isHidden = false
            }
        }.disposed(by: disposeBag)

        output.searchList.bind(to: searchView.collectionView.rx.items(cellIdentifier: "GifCell", cellType: GifCollectionViewCell.self)) {row, gif, cell in
            if let url = gif.images?.preview?.url{
                cell.setConfig(urlString: url)
                cell.prepareForReuse()
            }
        }.disposed(by: disposeBag)
        
        
    }
    

}


extension SearchViewController: SearchDataProtocol {
    func getDataCount() -> Int {
        return searchViewModel.getDataCount()
    }
    
    func getGif(index: Int) -> Gif {
        return searchViewModel.getGif(index: index)
    }
    
    func searchMore() {
        searchViewModel.searchMore()
    }
    
    
}
