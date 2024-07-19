//
//  FirstCell.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import UIKit


class FirstCell: UITableViewCell {

    static var identifier = "FirstCell"
    let operationNameLbl: UILabel = UIBuilder.label(size: 16, minSize: 15)
    let operationAmountLbl: UILabel = UIBuilder.label(size: 16, minSize: 15, alignment: .right)
    let operationDescLbl: UILabel = UIBuilder.label(color: .gray, size: 14, minSize: 13)
    let operationIconImgView: UIImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        let view = UIView()
        backgroundColor = .clear

        view.addSubview(operationNameLbl)
        view.addSubview(operationAmountLbl)
        view.addSubview(operationDescLbl)
        view.addSubview(operationIconImgView)
        contentView.addSubview(view)
        
        operationIconImgView.contentMode = .scaleAspectFit
        operationIconImgView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
            make.width.equalTo(35)
        }
        operationNameLbl.snp.makeConstraints { make in
            make.leading.equalTo(operationIconImgView.snp.trailing).offset(10)
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(operationDescLbl.snp.width)
            make.height.equalTo(20)
        }
        operationDescLbl.snp.makeConstraints { make in
            make.leading.equalTo(operationIconImgView.snp.trailing).offset(10)
            make.top.equalTo(operationNameLbl.snp.bottom)
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalTo(operationAmountLbl.snp.leading)
        }
        operationAmountLbl.snp.makeConstraints { make in
            make.centerY.equalTo(operationIconImgView.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
            make.width.greaterThanOrEqualTo(70)
        }
        view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
