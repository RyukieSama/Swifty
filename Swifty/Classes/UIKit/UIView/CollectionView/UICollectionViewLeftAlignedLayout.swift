//
//  UICollectionViewLeftAlignedLayout.swift
//  Alamofire
//
//  Created by wrq on 2024/5/21.
//

import UIKit

open class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?.map { $0.representedElementKind == nil ? layoutAttributesForItem(at: $0.indexPath)! : $0 }
    }

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes,
            collectionView != nil else {
            // should never happen
            return nil
        }

        // if the current frame, once stretched to the full row intersects the previous frame then they are on the same row
        if indexPath.item != 0,
            let previousFrame = layoutAttributesForItem(at: IndexPath(item: indexPath.item - 1, section: indexPath.section))?.frame,
            currentItemAttributes.frame.intersects(CGRect(x: -.infinity, y: previousFrame.origin.y, width: .infinity, height: previousFrame.size.height)) {
            // the next item on a line
            currentItemAttributes.frame.origin.x = previousFrame.origin.x + previousFrame.size.width + evaluatedMinimumInteritemSpacingForSection(at: indexPath.section)
        } else {
            // the first item on a line
            currentItemAttributes.frame.origin.x = evaluatedSectionInsetForSection(at: indexPath.section).left
        }
        return currentItemAttributes
    }

    func evaluatedMinimumInteritemSpacingForSection(at section: NSInteger) -> CGFloat {
        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSectionAt: section) ?? minimumInteritemSpacing
    }

    func evaluatedSectionInsetForSection(at index: NSInteger) -> UIEdgeInsets {
        return (collectionView?.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView!, layout: self, insetForSectionAt: index) ?? sectionInset
    }
}

