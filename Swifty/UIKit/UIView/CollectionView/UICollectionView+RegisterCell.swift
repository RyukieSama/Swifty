//
//  UICollectionView+RegisterCell.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public extension Swifty where Base: UICollectionView {
    func register(cellNibName: String) {
        base.register(UINib(nibName: cellNibName, bundle: nil), forCellWithReuseIdentifier: cellNibName)
    }
}
