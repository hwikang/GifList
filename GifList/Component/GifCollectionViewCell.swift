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
        self.contentView.addSubview(imageView)
         setUI()
    }
    
    override func prepareForReuse() {
        print("prepareForReuse")
        imageView.image = UIImage(named: "placeholder")

    }
    
    private func setUI() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    
    func setConfig(urlString: String) {
        DispatchQueue.global().async {
            let image = UIImage.gifImageWithURL(urlString)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) not implemented")
    }
  
}
