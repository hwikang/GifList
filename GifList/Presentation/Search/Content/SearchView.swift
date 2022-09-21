//
//  SearchView.swift
//  GifList
//
//  Created by 슈퍼 on 2022/09/21.
//

import UIKit
import RxSwift

class SearchView: UIView {
    private let disposeBag = DisposeBag()

    lazy var textField: SearchTextField = {
        let textField = SearchTextField()
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = DynamicHeightCollectionViewFlowLayout()
        layout.delegate = self
        layout.minimumLineSpacing = ComponentSize.collectionViewSpacing
        layout.minimumInteritemSpacing = ComponentSize.collectionViewSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    init() {
        super.init(frame: .zero)

        setProperty()

        setUI()
    }
    
    private func setUI() {
        addSubview(textField)
        addSubview(collectionView)
        setConstraint()
    }
    
    private func setConstraint() {
        textField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ComponentSize.searchTextFieldHeight)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setProperty() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: "GifCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchView: UICollectionViewDelegate, DynamicHeightLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        .zero
    }
    
    
}
