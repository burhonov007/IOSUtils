//
//  SecondCell.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit
import SwiftyJSON


class SecondCell: UITableViewCell {
    
    let userNameLbl: UILabel = UIBuilder.label(size: 14, minSize: 13)
    let cardNameLbl: UILabel = UIBuilder.label(color: .gray, size: 14, minSize: 13)
    let amountLbl: UILabel = UIBuilder.label(size: 16, minSize: 15, weight: .medium)
    let imgView: UIImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        contentView.backgroundColor = .white
        let textVStack = UIBuilder.stack(arrangedSubviews: [userNameLbl, cardNameLbl, amountLbl], axis: .vertical, spacing: 6, distribution: .fill, alignment: .leading)
        let mainHStack = UIBuilder.stack(arrangedSubviews: [imgView, textVStack], spacing: 15, distribution: .fill, alignment: .center)
        
        imgView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(62)
        }
        
        contentView.addSubview(mainHStack)
        mainHStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    
}
