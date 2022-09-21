//
//  SearchViewController.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import UIKit

class SearchViewController: UIViewController {

    
    lazy var controller: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: Strings.searchTabTitle.rawValue, at: 0, animated: true)
        control.insertSegment(withTitle: Strings.searchSetting.rawValue, at: 1, animated: true)
        
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)
        
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)
        
//        control.backgroundColor = .red
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.view.addSubview(controller)
        setConstraint()
    }
    
    private func setConstraint() {
        controller.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
    }
    

}
