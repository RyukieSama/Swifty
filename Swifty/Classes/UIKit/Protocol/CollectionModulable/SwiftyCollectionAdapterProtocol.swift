//
//  SwiftyCollectionAdapterProtocol.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/7/3.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

public protocol SwiftyCollectionAdapterProtocol:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    // Redundant conformance constraint 'Self': 是个Swift 的 bug
    var collectionView: UICollectionView? { get set }
}

#endif
