//
//  CollectionModuleCenterAdapter.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/7/3.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

public class CollectionModuleCenterAdapter: NSObject {
    
    public init(collectionView: UICollectionView, moduleCenter: CollectionModuleCenterProtocol) {
        self.collectionView = collectionView
        self.moduleCenter = moduleCenter
        
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        moduleCenter.loadedModules.forEach {
            $0.owner = moduleCenter.owner
            $0.collectionView = collectionView
            $0.registCellToCollectionView(to: collectionView)
        }
    }
    
    weak public var collectionView: UICollectionView?
    weak public var moduleCenter: CollectionModuleCenterProtocol?
}

extension CollectionModuleCenterAdapter: SwiftyCollectionAdapterProtocol {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return moduleCenter?.loadedModules.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moduleCenter?.module(for: section)?.rowCount ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return moduleCenter?.module(for: indexPath.section)?.cellForIndexPath(indexPath: indexPath, collectionView: collectionView) ?? collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
    }
    
    // MARK: - Layout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return moduleCenter?.module(for: indexPath.section)?.sizeForItemAtIndexPath(indexPath: indexPath) ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return moduleCenter?.module(for: section)?.minimumLineSpacing ?? CGFloat.leastNormalMagnitude
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return moduleCenter?.module(for: section)?.minimumInteritemSpacing ?? CGFloat.leastNormalMagnitude
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return moduleCenter?.module(for: section)?.referenceSizeForHeader ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return moduleCenter?.module(for: section)?.sectionEdgeInsets ?? .zero
    }
    
    // MARK: - Delete
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moduleCenter?.module(for: indexPath.section)?.cellDidClickAtIndexPath(indexPath: indexPath)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        moduleCenter?.loadedModules.forEach {
            $0.moduleViewWillBeginDragging(scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        moduleCenter?.loadedModules.forEach {
            $0.moduleViewDidEndDecelerating(scrollView)
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        moduleCenter?.loadedModules.forEach {
            $0.moduleViewDidEndDragging(scrollView, willDecelerate: decelerate)
        }
    }
    
}

#endif
