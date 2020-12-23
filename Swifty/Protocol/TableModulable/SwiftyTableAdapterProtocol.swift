//
//  SwiftyTableAdapterProtocol.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/12/23.
//

import UIKit

public protocol SwiftyTableAdapterProtocol:
    UITableViewDelegate,
    UITableViewDataSource {
    // Redundant conformance constraint 'Self': 是个Swift 的 bug
    var tableView: UITableView? { get set }
}
