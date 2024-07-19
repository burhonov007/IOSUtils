//
//  WelcomeVC.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit
import SwiftyJSON


class WelcomeVC: UIViewController {
    
    let typesData = JSONData.tableViewTypesJson.arrayValue
    
    lazy var reustableTable = GenericTableView(
        cellClass: UITableViewCell.self,
        style: .insetGrouped,
        config: { json, cell, indexPath in
            cell.textLabel?.text = json["title"].stringValue
        },
        selectHandler: { json, index in
            print(json)
            if json["id"].stringValue == "01" {
                let vc = TableViewViaSection()
                vc.title = json["title"].stringValue
                self.navigationController?.pushViewController(vc, animated: true)
            } else if json["id"].stringValue == "02" {
                let vc = TableViewWithoutSection()
                vc.title = json["title"].stringValue
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        title = "Generic TableViews"
        view.backgroundColor = .background
    }
    
    func setupTable() {
        view.addSubview(reustableTable)
        
        
        reustableTable.items = typesData
        reustableTable.rowCount = { _ in
            return self.typesData.count
        }
        
        reustableTable.backgroundColor = .clear
        
        reustableTable.headerTitle = {
            switch $0 {
            case 0:
                return "UITableView"
            default:
                return ""
            }
        }
        
        reustableTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        reustableTable.sectionFooterHeight = 0

        
    }
    
}

