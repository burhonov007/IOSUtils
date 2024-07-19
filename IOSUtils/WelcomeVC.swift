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
            if json["data"][indexPath.row]["id"].stringValue == "03" {
                cell.imageView?.image = UIImage(named: "history7")
                cell.imageView?.addParallax(minRelativeValue: -30, maxRelativeValue: 30)
            }
            cell.textLabel?.text = json["data"][indexPath.row]["title"].stringValue
        },
        selectHandler: { json, index in
            if json["data"][index.row]["id"].stringValue == "01" {
                let vc = TableViewViaSection()
                vc.title = json["data"][index.row]["title"].stringValue
                self.navigationController?.pushViewController(vc, animated: true)
            } else if json["data"][index.row]["id"].stringValue == "02" {
                let vc = TableViewWithoutSection()
                vc.title = json["data"][index.row]["title"].stringValue
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
        
        reustableTable.sectionCount = {
            return self.typesData.count
        }
        reustableTable.items = typesData
        reustableTable.rowCount = {
            return self.typesData[$0]["data"].count
        }
        
        reustableTable.backgroundColor = .clear
        
        reustableTable.headerTitle = {
            return self.typesData[$0]["sectionTitle"].stringValue
        }
        
        reustableTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        reustableTable.sectionFooterHeight = 0

        
    }
    
}

