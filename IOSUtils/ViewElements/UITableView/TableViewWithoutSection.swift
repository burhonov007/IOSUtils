//
//  TableViewWithoutSection.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit
import SwiftyJSON


class TableViewWithoutSection: UIViewController {
    
    
    let cardData = JSONData.cardsJSON["data"].arrayValue
    lazy var newTableView = GenericTableView(items: self.cardData, cellClass: SecondCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func setupTable() {
        
        newTableView.config = { json, cell, _ in
            cell.imgView.image = UIImage(named: json["imgName"].stringValue)
            cell.userNameLbl.text = json["userName"].stringValue.uppercased()
            cell.cardNameLbl.text = json["cardName"].stringValue.uppercased()
            
            if let amount = json["amount"].string {
                cell.amountLbl.text = amount
            } else {
                cell.amountLbl.isHidden = true
            }
        }
        
        newTableView.selectHandler = { json, _ in
            print("++++++++++++++++++++++")
            print(json)
            print("++++++++++++++++++++++")
        }
        
        newTableView.rowCount = { _ in
            return self.cardData.count
        }
        
        self.view.addSubview(newTableView)
        newTableView.backgroundColor = .background
        newTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        newTableView.sectionHeaderHeight = 0
        newTableView.sectionFooterHeight = 0
    }
    
}

