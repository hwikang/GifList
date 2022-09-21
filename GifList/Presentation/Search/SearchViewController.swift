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
//        control.backgroundColor = .red
        return control
    }()
    
    lazy var searchView: SearchView = {
        let view = SearchView()
        view.backgroundColor = .red
        return view
    }()
    lazy var settingView: SettingView = {
        let view = SettingView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindView()
        bindViewModel()
    }
    
    private func bindView() {
        searchView.textField.rx.text.bind { [weak self] text in
            if let text = text {
                self?.searchText.accept(text)
            }
        }
    }
    
    
    private func setUI() {
        
        self.view.addSubview(segmentedControl)
        self.view.addSubview(searchView)
        self.view.addSubview(settingView)

        setConstraint()
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
    }
    
    private func setConstraint() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        setContentViewConstraint(view: searchView)
        setContentViewConstraint(view: settingView)
    }
    private func setContentViewConstraint(view: UIView) {
        view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
        }
    }
    

}
