//
//  TableViewViaSection.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit
import SwiftyJSON


class TableViewViaSection: UIViewController {
    
    let historyData = JSONData.historyJSON.arrayValue
    
    let reustableTable = GenericTableView(
        cellClass: FirstCell.self,
        style: .insetGrouped,
        config: { json, cell, indexPath in
            let item = json["data"][indexPath.row]
            
            if item["amount"].stringValue.contains("+") {
                cell.operationAmountLbl.textColor = .systemGreen
            } else {
                cell.operationAmountLbl.textColor = .label
            }
            
            if item["operationInfo"].stringValue.contains("Неуспешно") {
                cell.operationDescLbl.textColor = .systemRed
            } else {
                cell.operationDescLbl.textColor = .gray
            }
            
            cell.operationNameLbl.text = item["operationName"].stringValue
            cell.operationDescLbl.text = item["operationInfo"].stringValue
            cell.operationAmountLbl.text = item["amount"].stringValue
            cell.operationIconImgView.image = UIImage(named: item["ico"].stringValue)
        },
        selectHandler: { json, index in
            print("----------------------")
            print(json["data"][index.row])
            print("----------------------")
        }
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func setupTable() {
        view.addSubview(reustableTable)
        
        reustableTable.items = historyData
        reustableTable.sectionCount = { return self.historyData.count }
        reustableTable.rowCount = {
            return self.historyData[$0]["data"].arrayValue.count
        }
        
        reustableTable.backgroundColor = .background
        reustableTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        reustableTable.sectionHeaderHeight = 36
        reustableTable.sectionFooterHeight = 0
    
        reustableTable.headerView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.backgroundColor = .systemGray6
            let dayOfTheWeekLbl = UIBuilder.label(text: self.historyData[$0]["dateName"].stringValue, color: .gray, size: 14, minSize: 13)
            let dateLbl = UIBuilder.label(text: self.historyData[$0]["date"].stringValue, color: .gray, size: 14, minSize: 13, alignment: .right)
            let hStack = UIBuilder.stack(arrangedSubviews: [dayOfTheWeekLbl, dateLbl], distribution: .fillEqually)
            view.addSubview(hStack)
            hStack.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(10)
                make.top.bottom.equalToSuperview()
            }
            return view
        }
        
    }
    
}

