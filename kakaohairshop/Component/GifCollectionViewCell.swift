//
//  GifCollectionViewCell.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/17.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
       return imageView
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.backgroundColor = .red
         addSubview(imageView)
         setUI()
    }
    
    private func setUI() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setConfig(image: UIImage) {
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) not implemented")
      }
  
}
