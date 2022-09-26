//
//  SettingView.swift
//  GifList
//
//  Created by 슈퍼 on 2022/09/21.
//

import UIKit
import DLRadioButton
import RxRelay
import RxSwift

class SettingView: UIView {
    
    private let numberOfColumns = BehaviorRelay<Int>(value: 2)
    lazy var numberOfColumnsTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.numberOfColumnsTitle.rawValue
        label.font = label.font.withSize(20)
        return label
    }()
    lazy var numberOfColumnsDesc: UILabel = {
        let label = UILabel()
        label.text = Strings.numberOfColumnsDesc.rawValue
        label.font = label.font.withSize(14)
        return label
    }()
    
    lazy var firstRadioButton: DLRadioButton = {
        let button = createRadioButton(title: Strings.twoColumns.rawValue, tag: 0)
        button.isSelected = true
        
        return button
    }()
    
    lazy var secondRadioButton: DLRadioButton = {
        let button = createRadioButton(title: Strings.threeColumns.rawValue, tag: 1)
        return button
    }()
    
   
    init() {
        super.init(frame: .zero)

        setUI()
    }
    private func setUI() {
        addSubview(numberOfColumnsTitle)
        addSubview(numberOfColumnsDesc)
        addSubview(firstRadioButton)
        addSubview(secondRadioButton)
        firstRadioButton.otherButtons = [secondRadioButton]
        setConstraint()
    }
    
    private func setConstraint() {
        numberOfColumnsTitle.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        numberOfColumnsDesc.snp.makeConstraints { make in
            make.top.equalTo(numberOfColumnsTitle.snp.bottom).offset(15)
            make.left.equalToSuperview()
        }
        firstRadioButton.snp.makeConstraints { make in
            make.top.equalTo(numberOfColumnsDesc.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        secondRadioButton.snp.makeConstraints { make in
            make.top.equalTo(numberOfColumnsDesc.snp.bottom).offset(20)
            make.left.equalTo(firstRadioButton.snp.right)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
//    private func setEvent() {
//        print("setEvent")
//
//    }
    
    private func createRadioButton(title: String, tag: Int) -> DLRadioButton {
        let button = DLRadioButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(16)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.tag = tag
        button.addTarget(self, action: #selector(selectButton(_:)), for: UIControl.Event.touchUpInside);

        return button
    }
    
    @objc func selectButton(_ sender:DLRadioButton) {
        print("radioButton \(sender.tag)")
        numberOfColumns.accept(sender.tag == 0 ? 2 : 3)
    }
    // MARK: Public function
    public func numberOfColumnsObservable() -> Observable<Int> {
        return numberOfColumns.asObservable()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
