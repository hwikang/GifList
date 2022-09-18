//
//  DynamicHeightCollectionViewFlowLayout.swift
//  kakaohairshop
//
//  Created by 슈퍼 on 2022/09/18.
//

import UIKit

protocol DynamicHeightLayoutDelegate: AnyObject {
  func collectionView(
    _ collectionView: UICollectionView,
    sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}


class DynamicHeightCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var delegate : DynamicHeightLayoutDelegate?
    
    private let numberOfColumns = 2
    private let collectionViewSpacing: CGFloat = CGFloats.collectionViewSpacing.rawValue
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let inset = collectionView.contentInset
        return collectionView.bounds.width - inset.left - inset.right
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        print("call prepare")
        guard cache.isEmpty, let collectionView = collectionView else { return }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)

        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate?.collectionView(collectionView, sizeForPhotoAtIndexPath: indexPath) ?? CGSize(width: 180, height: 180)
            let ratio = photoSize.height / photoSize.width
            let photoHeight = columnWidth * ratio
            let height = collectionViewSpacing * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: collectionViewSpacing, dy: collectionViewSpacing)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < numberOfColumns - 1 ? column + 1 : 0
            
        }
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
      // Loop through the cache and look for items in the rect
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
}
