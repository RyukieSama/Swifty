//
//  CollectionModuleCenterProtocol.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/7/3.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import UIKit

public protocol CollectionModuleCenterProtocol where Self: NSObject {
    static func moduleCenter<T: CollectionModuleCenterProtocol>(collectionView: UICollectionView, owner: UIViewController) -> T
    
    func bind(collectionView: UICollectionView, owner: UIViewController)
    
    // MARK: - Life
    func loadModules()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidAppear()
    func viewDidDisappear()
    
    // MARK: - Refresh
    func headerPullToRefresh()
    func footerPullToRefresh()
    
    // MARK: - Module
    func module(for section: Int) -> CollectionModulableProtocol?
    
    /// 注意用Weak
    var owner: UIViewController? { get set }
    /// 注意用Weak
    var collectionView: UICollectionView? { get set }
    var adapter: CollectionModuleCenterAdapter? { get set}
    
    var loadedModules: [CollectionModulableProtocol] { get set }
}

public extension CollectionModuleCenterProtocol {
    static func moduleCenter<T: CollectionModuleCenterProtocol>(collectionView: UICollectionView, owner: UIViewController) -> T {
        let center = T()
        center.owner = owner
        center.collectionView = collectionView
        center.loadModules()
        center.adapter = CollectionModuleCenterAdapter(collectionView: collectionView, moduleCenter: center)
        return center
    }
    
    func bind(collectionView: UICollectionView, owner: UIViewController) {
        self.owner = owner
        self.collectionView = collectionView
        self.loadModules()
        self.adapter = CollectionModuleCenterAdapter(collectionView: collectionView, moduleCenter: self)
    }
    
    // MARK: - Life
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func viewDidAppear() {
        for provider in loadedModules {
            provider.didAppear()
        }
    }
    
    func viewDidDisappear() {
        for provider in loadedModules {
            provider.didDisappear()
        }
    }
    
    // MARK: - Refresh
    func headerPullToRefresh() {
        loadedModules.forEach {
            $0.headerPullToRefresh()
        }
    }
    
    func footerPullToRefresh() {
        loadedModules.forEach {
            $0.footerPullToRefresh()
        }
    }
        
    // MARK: - Module
    func module(for section: Int) -> CollectionModulableProtocol? {
        if section >= loadedModules.count {
            return nil
        }
        return loadedModules[section]
    }
}
