//
//  SearchView.swift
//  GifList
//
//  Created by 슈퍼 on 2022/09/21.
//

import UIKit
import RxSwift

protocol SearchDataProtocol {
    func getDataCount() -> Int
    func getGif(index: Int) -> Gif
    func searchMore()
}

class SearchView: UIView {
    private let disposeBag = DisposeBag()
    private var columnCount = 2
    
    lazy var textField: SearchTextField = {
        let textField = SearchTextField()
        textField.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
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
    public var searchDataDelegate: SearchDataProtocol?
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
    
    private func setEvent() {
        
        collectionView.rx.prefetchItems
            .compactMap({ indexPath in
                indexPath.last?.row
            })
            .filter{[weak self] row in
                guard let count = self?.searchDataDelegate?.getDataCount() else { return false }
                print("Data count \(count)")
                return row >= count - 1
            }
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind {[weak self] row in
                guard let self = self else { return }
                print("search more")
                self.searchDataDelegate?.searchMore()
            }.disposed(by: disposeBag)
    }
    
    //MARK: Public function
    public func setColumnCount(_ count: Int) {
        self.columnCount = count
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchView: UICollectionViewDelegate, DynamicHeightLayoutDelegate {
    func numberOfColumns() -> Int {
        return columnCount
    }
    
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        let gif = searchDataDelegate?.getGif(index: indexPath.row)
        return getImageSize(images: gif?.images)
        
    }
    
    private func getImageSize(images: Images?) -> CGSize {
        guard let image = images?.preview,
              let width = image.width,
              let height = image.height else { return CGSize(width: 100, height: 100) }
        return CGSize(width: width, height: height)

    }

}
