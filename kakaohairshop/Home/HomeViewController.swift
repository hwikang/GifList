//
//  TabBarController.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import UIKit
import SnapKit
import RxSwift
class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    
    // MARK: - UI
    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
        let layout = DynamicHeightCollectionViewFlowLayout()
        layout.delegate = self
        layout.minimumLineSpacing = CGFloats.collectionViewSpacing.rawValue
        layout.minimumInteritemSpacing = CGFloats.collectionViewSpacing.rawValue
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
//        collectionView.backgroundColor = .white
        return collectionView
    }()
        
    private let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewdidLoad")
        viewModel.fetchTrends()
        bindViewModel()
        
        setProperty()
        setUI()
        setEvent()
    }
    
    private func setProperty() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: "GifCell")
    }
    
    private func setUI() {
        self.view.addSubview(collectionView)
        setConstraint()
    }
    
    private func setConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    
    private func bindViewModel() {
        let output = viewModel.transform(input: HomeViewModel.Input())
        output.trends.bind(to: collectionView.rx.items(cellIdentifier: "GifCell", cellType: GifCollectionViewCell.self)) { row,gif,cell in
            if let url = gif.images?.preview?.url{
                print("setConfig \(row)")

                cell.setConfig(urlString: url)
                cell.prepareForReuse()
            }
            
        }
        .disposed(by: disposeBag)
    }
    
    private func setEvent() {
        
        collectionView.rx.prefetchItems
            .compactMap({ indexPath in
                indexPath.last?.row
            })
            .bind {[weak self] row in
                guard let self = self else { return }
                if row > self.viewModel.getDataCount() - 2 {
                    self.viewModel.fetchTrends()
                }
        }.disposed(by: disposeBag)
    }
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout , DynamicHeightLayoutDelegate{
    func collectionView(
          _ collectionView: UICollectionView,
          sizeForPhotoAtIndexPath indexPath:IndexPath) -> CGSize {
              let imageSize = viewModel.getImageSize(index: indexPath.row)

              print(imageSize)
//              guard let cell = collectionView.cellForItem(at: indexPath) as? GifCollectionViewCell else { return 0 }
//              print("cell \(cell)")
//              guard let image = cell.imageView.image else {return 0}
//              print("Height \(image.size.height)")
              return imageSize
      }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let imageSize = viewModel.getImageSize(index: indexPath.row)
//        let width = collectionView.frame.width
//        let itemsPerRow: CGFloat = 2
//        let cellWidth = (width - CGFloats.collectionViewSpacing.rawValue) / itemsPerRow
//
//        let multiply = cellWidth / imageSize.width
//        let cellHeight = imageSize.height * multiply
//        print("cellHeight \(cellHeight)")
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
    
}
