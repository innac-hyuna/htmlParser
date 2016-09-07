//
//  DataRealmTVCell.swift
//  htmlParser
//
//  Created by FE Team TV on 9/7/16.
//  Copyright © 2016 courses. All rights reserved.
//

import UIKit
import SnapKit

class DataRealmTVCell: UITableViewCell {
    
    var idLabel: UILabel!
    var title: UILabel!
    var label: UILabel!
    var format: UILabel!
    var country: UILabel!
    var released: UILabel!
    var genre: UILabel!
    var price: UILabel!
    
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        idLabel = UILabel()
        idLabel.textColor = UIColor.textColor()
        idLabel.font = UIFont.fontFamilySize(14)
        contentView.addSubview(idLabel)
    
        title = UILabel()
        title.textColor = UIColor.textColor()
        title.font = UIFont.fontFamilySize(14)
        contentView.addSubview(title)
    
        label = UILabel()
        label.textColor = UIColor.textColor()
        label.font = UIFont.fontFamilySize(14)
        contentView.addSubview(label)
    
        format = UILabel()
        format.textColor = UIColor.textColor()
        format.font = UIFont.fontFamilySize(14)
        contentView.addSubview(format)
    
        country = UILabel()
        country.textColor = UIColor.textColor()
        country.font = UIFont.fontFamilySize(14)
        contentView.addSubview(country)
    
        released = UILabel()
        released.textColor = UIColor.textColor()
        released.font = UIFont.fontFamilySize(14)
        contentView.addSubview(released)
    
        genre = UILabel()
        genre.textColor = UIColor.textColor()
        genre.font = UIFont.fontFamilySize(14)
        contentView.addSubview(genre)
    
        price = UILabel()
        price.textColor = UIColor.textColor()
        price.font = UIFont.fontFamilySize(14)
        contentView.addSubview(price)
    
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayouts() {
        
        // 1 line
      
        idLabel.snp_makeConstraints { (make) in
            make.top.equalTo(contentView.snp_top).offset(10)
            make.left.equalTo(contentView.snp_left).offset(10)
            make.width.equalTo(35)
            make.height.equalTo(20)
        }
       
        title.snp_makeConstraints { (make) in
            make.top.equalTo(contentView.snp_top).offset(10)
            make.left.equalTo(idLabel.snp_left).offset(10)
            make.width.equalTo(contentView).offset(-60)
            make.height.equalTo(20)
        }
        
        // 2 line
        
        label.snp_makeConstraints { (make) in
            make.top.equalTo(idLabel.snp_bottom).offset(10)
            make.left.equalTo(contentView.snp_left).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        format.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom).offset(10)
            make.left.equalTo(label.snp_right).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        country.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom).offset(10)
            make.left.equalTo(format.snp_right).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        //3
        
        genre.snp_makeConstraints { (make) in
            make.top.equalTo(label.snp_bottom).offset(10)
            make.left.equalTo(contentView.snp_left).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        released.snp_makeConstraints { (make) in
            make.top.equalTo(format.snp_bottom).offset(10)
            make.left.equalTo(genre.snp_right).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        price.snp_makeConstraints { (make) in
            make.top.equalTo(country.snp_bottom).offset(10)
            make.left.equalTo(released.snp_right).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
