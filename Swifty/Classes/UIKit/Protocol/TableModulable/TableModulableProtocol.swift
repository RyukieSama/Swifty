//
//  TableModulableProtocol.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/12/23.
//

#if !os(macOS)

import UIKit

public protocol TableModulableProtocol: AnyObject {
    // MARK: - CollectionViewDataSource
    func cellFor(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func registCell(to tableView: UITableView)
    func height(for indexPath: IndexPath) -> CGFloat
    
    // MARK: - CollectionViewDelegate
    func cellDidClick(at indexPath: IndexPath)
    
    // MARK: - Scroll
    func moduleViewWillBeginDragging(_ scrollView: UIScrollView)
    func moduleViewDidEndDecelerating(_ scrollView: UIScrollView)
    func moduleViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    
    // MARK: - Refresh
    func headerPullToRefresh()
    func footerPullToRefresh()
    
    // MARK: - Getter
    var rowCount: Int { get }
    
    // MARK: - Life
    func willAppear()
    func willDisappear()
    func didAppear()
    func didDisappear()
    /// 注意用Weak
    var owner: UIViewController? { get set }
    /// 注意用Weak
    var tableView: UITableView? { get set }
}

public extension TableModulableProtocol {
    // MARK: - CollectionViewDataSource
    func registCell(to tableView: UITableView) {}
    func height(for indexPath: IndexPath) -> CGFloat { .zero }
    
    // MARK: - CollectionViewDelegate
    func cellDidClick(at indexPath: IndexPath) {}
    
    // MARK: - Scroll
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
    
    // MARK: - Getter
    var rowCount: Int { return 0 }
}

#endif
