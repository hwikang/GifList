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
            .filter({ row in
                row >= self.viewModel.getDataCount() - 1
            })
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind {[weak self] row in
                guard let self = self else { return }
                print("fetch")
                self.viewModel.fetchTrends()
        }.disposed(by: disposeBag)
    }
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout , DynamicHeightLayoutDelegate{
    func collectionView(
          _ collectionView: UICollectionView,
          sizeForPhotoAtIndexPath indexPath:IndexPath) -> CGSize {
              let imageSize = viewModel.getImageSize(index: indexPath.row)
              return imageSize
      }
    
    
}
