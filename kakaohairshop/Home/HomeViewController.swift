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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .blue
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
            
            print(gif.images?.original?.url)
//            cell.setConfig(image: UIImage)
            
        }
        .disposed(by: disposeBag)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let itemsPerRow: CGFloat = 2
        let cellWidth = (width - 10) / itemsPerRow

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
