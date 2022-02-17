//
//  CollectionModulableProtocol.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/6/13.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

public protocol CollectionModulableProtocol: class {
    // MARK: - CollectionViewDataSource
    func cellForIndexPath(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell
    func registCellToCollectionView(to collectionView: UICollectionView)
    func sizeForItemAtIndexPath(indexPath: IndexPath) -> CGSize
    // MARK: - CollectionViewDelegate
    func cellDidClickAtIndexPath(indexPath: IndexPath)
    func heightForHeaderInSection(indexPath: IndexPath) -> CGFloat
    // MARK: - Scroll
    func moduleViewWillBeginDragging(_ scrollView: UIScrollView)
    func moduleViewDidEndDecelerating(_ scrollView: UIScrollView)
    func moduleViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    // MARK: - Refresh
    func headerPullToRefresh()
    func footerPullToRefresh()
    
    // MARK: - CollectionView Getter
    var rowCount: Int { get }
    var minimumLineSpacing: CGFloat { get }
    var minimumInteritemSpacing: CGFloat { get }
    var referenceSizeForFooter: CGSize { get }
    var referenceSizeForHeader: CGSize { get }
    var sectionEdgeInsets: UIEdgeInsets { get }
    
    // MARK: - Life
    func willAppear()
    func willDisappear()
    func didAppear()
    func didDisappear()
    
    // MARK: - Owner
    /// 注意用Weak
    var owner: UIViewController? { get set }
    /// 注意用Weak
    var collectionView: UICollectionView? { get set }
}

public extension CollectionModulableProtocol {
    // MARK: - CollectionView
    func sizeForItemAtIndexPath(indexPath: IndexPath) -> CGSize { return .zero }
    
    func cellDidClickAtIndexPath(indexPath: IndexPath) {}
    
    func heightForHeaderInSection(indexPath: IndexPath) -> CGFloat { return 0.0 }
    
    func cellForIndexPath(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
    }
    
    func registCellToCollectionView(to collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
    
    func moduleViewWillBeginDragging(_ scrollView: UIScrollView) {}
    func moduleViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    func moduleViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    
    // MARK: - Refresh
    func headerPullToRefresh() {}
    func footerPullToRefresh() {}
    
    // MARK: - Life
    func willAppear() {}
    func willDisappear() {}
    func didAppear() {}
    func didDisappear() {}
    
    // MARK: - CollectionView Getter
    var rowCount: Int { return 0 }
    var minimumLineSpacing: CGFloat { return CGFloat.leastNormalMagnitude }
    var minimumInteritemSpacing: CGFloat { return CGFloat.leastNormalMagnitude }
    var referenceSizeForFooter: CGSize { return .zero }
    var referenceSizeForHeader: CGSize { return .zero }
    var sectionEdgeInsets: UIEdgeInsets { return .zero }
}

#endif
