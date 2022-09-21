//
//  SearchTextField.swift
//  GifList
//
//  Created by 슈퍼 on 2022/09/21.
//

import Foundation
import UIKit


class SearchTextField: UITextField {
    lazy var iconView: UIView = {
        let view = UIView()
        return view
    }()
      
    lazy var clearView: UIView = {
     let view = UIView()
      return view
    }()
      
    lazy var clearButton: UIButton = {
      let button = UIButton()
      return button
    }()
      
    
    lazy var searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
       return imageView
    }()
      
    public init(){
        super.init(frame: .zero)
        setUI()
    }
    private func setUI() {
        leftView = iconView
        leftViewMode = .always
        rightView = clearView
        rightViewMode = .always
        iconView.addSubview(searchIcon)
        clearView.addSubview(clearButton)
        setConstraint()
    }
    private func setConstraint() {
        searchIcon.snp.makeConstraints{ make in
           make.centerY.equalToSuperview()
           make.left.equalTo(ComponentSize.searchTextFieldPadding)
            make.width.height.equalTo(ComponentSize.searchTextFieldIconWidth)
        }
         
        clearButton.snp.makeConstraints { make in
            make.height.width.equalTo(ComponentSize.searchTextFieldClearButtonWidth)
           make.centerY.left.equalToSuperview()
        }
    }
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return  CGRect(x: 0, y: 0, width: ComponentSize.searchTextFieldHeight, height: ComponentSize.searchTextFieldHeight)

       }
       
       open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
           
           return CGRect(x: self.frame.width - ComponentSize.searchTextFieldClearButtonWidth - ComponentSize.searchTextFieldPadding, y: 0, width: ComponentSize.searchTextFieldClearButtonWidth + ComponentSize.searchTextFieldPadding, height: self.frame.height)
       }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
