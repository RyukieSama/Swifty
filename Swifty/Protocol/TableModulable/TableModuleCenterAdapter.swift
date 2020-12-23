//
//  TableModuleCenterAdapter.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/12/23.
//

import Foundation

public class TableModuleCenterAdapter: NSObject {
    public init(table: UITableView, center: TableModuleCenterProtocol) {
        tableView = table
        moduleCenter = center
        
        super.init()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        center.loadedModules.forEach {
            $0.owner = center.owner
            $0.tableView = table
            $0.registCell(to: table)
        }
    }

    // MARK: - Life
    
    // MARK: - Function-Public
    
    // MARK: - Function-Private

    // MARK: Buiness
    
    // MARK: Action
    
    // MARK: Request
    
    // MARK: - VarLet-Public
    
    // MARK: - VarLet-Private
    weak public var tableView: UITableView?
    weak public var moduleCenter: TableModuleCenterProtocol?
}

extension TableModuleCenterAdapter: SwiftyTableAdapterProtocol {
    public func numberOfSections(in tableView: UITableView) -> Int {
        moduleCenter?.loadedModules.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moduleCenter?.module(for: section)?.rowCount ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        moduleCenter?.module(for: indexPath.section)?.cellFor(indexPath: indexPath, tableView: tableView) ?? tableView.dequeueReusableCell(withIdentifier: "UITableViewCell()", for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        moduleCenter?.module(for: indexPath.section)?.height(for: indexPath) ?? .zero
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moduleCenter?.module(for: indexPath.section)?.cellDidClick(at: indexPath)
    }
}
