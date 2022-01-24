//
//  TableModuleCenterProtocol.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/12/23.
//

#if !os(macOS)

import UIKit

public protocol TableModuleCenterProtocol where Self: NSObject {
    static func moduleCenter<T: TableModuleCenterProtocol>(tableView: UITableView, owner: UIViewController) -> T
        
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
    func module(for section: Int) -> TableModulableProtocol?
    
    /// 注意用Weak
    var owner: UIViewController? { get set }
    /// 注意用Weak
    var tableView: UITableView? { get set }
    var adapter: TableModuleCenterAdapter? { get set}
    var loadedModules: [TableModulableProtocol] { get set }
}

public extension TableModuleCenterProtocol {
    static func moduleCenter<T: TableModuleCenterProtocol>(tableView: UITableView, owner: UIViewController) -> T {
        let center = T()
        center.owner = owner
        center.tableView = tableView
        center.loadModules()
        center.adapter = TableModuleCenterAdapter(table: tableView, center: center)
        return center
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
    func module(for section: Int) -> TableModulableProtocol? {
        if section >= loadedModules.count {
            return nil
        }
        return loadedModules[section]
    }
}

#endif
