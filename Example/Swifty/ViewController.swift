//
//  ViewController.swift
//  Swifty
//
//  Created by RyukieSama on 02/17/2022.
//  Copyright (c) 2022 RyukieSama. All rights reserved.
//

import UIKit
import RyukieSwifty

enum ExampleTypes: String, CaseIterable {
    case ScreenShield
    case ScreenShieldOC
    case TableView
    case FullScreen
    
    func createController() -> UIViewController {
        switch self {
        case .ScreenShield:
            return ScreenShieldViewController()
        case .ScreenShieldOC:
            return OCScreenShieldViewController()
        case .TableView:
            return SwiftyTableViewController()
        case .FullScreen:
            return FullScreenViewController()
        }
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = CGRect(origin: .zero, size: SwiftyDefine.Device.screenSize)
        tableView.reloadData()
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = ExampleTypes.allCases[indexPath.row]
        let vc = item.createController()
        vc.navigationItem.title = item.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = ExampleTypes.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ExampleTypes.allCases.count
    }
}
