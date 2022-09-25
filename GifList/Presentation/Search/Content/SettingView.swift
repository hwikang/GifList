//
//  SettingView.swift
//  GifList
//
//  Created by 슈퍼 on 2022/09/21.
//

import UIKit
import DLRadioButton

class SettingView: UIView {
    
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
        let firstButton = DLRadioButton()
        firstButton.setTitle(Strings.twoColumns.rawValue, for: .normal)
        firstButton.titleLabel?.font = firstButton.titleLabel?.font.withSize(16)
        firstButton.setTitleColor(UIColor.black, for: .normal)
        firstButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left

        return firstButton
    }()
    
    lazy var secondRadioButton: DLRadioButton = {
        let secondButton = DLRadioButton()
        secondButton.setTitle(Strings.threeColumns.rawValue, for: .normal)
        secondButton.titleLabel?.font = secondButton.titleLabel?.font.withSize(16)
        secondButton.setTitleColor(UIColor.black, for: .normal)
        secondButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left

        return secondButton
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
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
