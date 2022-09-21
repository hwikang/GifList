//
//  SearchView.swift
//  GifList
//
//  Created by 슈퍼 on 2022/09/21.
//

import Foundation
import UIKit


class SearchView: UIView {
    
    lazy var textField: SearchTextField = {
        let textField = SearchTextField()
        textField.backgroundColor = .lightGray

        return textField
    }()
    
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .red
        setUI()
    }
    
    private func setUI() {
        addSubview(textField)
        setConstraint()
    }
    
    private func setConstraint() {
        textField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ComponentSize.searchTextFieldHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
