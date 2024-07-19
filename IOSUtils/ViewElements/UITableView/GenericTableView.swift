//
//  GenericTableView.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit
import SwiftyJSON


class GenericTableView<Cell: UITableViewCell>: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private let cellIdentifier = "Cell"
    var items: [JSON]
    
    var config: (JSON, Cell, IndexPath) -> ()
    var selectHandler: (JSON, IndexPath) -> ()
    
    var rowCount: ((Int) -> (Int))?
    var sectionCount: (() -> (Int))?
    
    var headerView: ((Int) -> (UIView?))?
    var footerView: ((Int) -> (UIView?))?
    
    var headerTitle: ((Int) -> (String?))?
    var footerTitle: ((Int) -> (String?))?
    
    init(items: [JSON] = [], cellClass: Cell.Type, style: UITableView.Style = .plain, config: @escaping (JSON, Cell, IndexPath) -> (), selectHandler: @escaping (JSON, IndexPath) -> ()) {
        self.items = items
        self.config = config
        self.selectHandler = selectHandler
        super.init(frame: .zero, style: style)
        
        self.delegate = self
        self.dataSource = self
        self.register(cellClass, forCellReuseIdentifier: cellIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount?() ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount?(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
        if let _ = sectionCount?() {
            config(items[indexPath.section], cell, indexPath)
        } else {
            config(items[indexPath.row], cell, indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = sectionCount?() {
            selectHandler(items[indexPath.section], indexPath)
        } else {
            selectHandler(items[indexPath.row], indexPath)
        }
        deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView?(section) ?? nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView?(section) ?? nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle?(section) ?? nil
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return footerTitle?(section) ?? nil
    }
    
}

extension GenericTableView {
    func updateData(_ items: [JSON]) {
        self.items = items
        self.reloadData()
    }
}
