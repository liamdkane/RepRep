//
//  RepRepSectionHeader.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit

struct RepRepSectionHeaderConstructor {
    static func update(header: UITableViewHeaderFooterView) {
        header.tintColor = UIColor.repCream
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        header.textLabel?.lineBreakMode = .byWordWrapping
        header.textLabel?.numberOfLines = 2
        header.textLabel?.textAlignment = .center
        
        let bottomBorder = RepRepBorderView()
        
        header.addSubview(bottomBorder)
        bottomBorder.snp.makeConstraints { (view) in
            view.bottom.centerX.equalToSuperview()
            view.height.equalTo(1)
            view.width.equalToSuperview().multipliedBy(0.7)
        }
        
        let topBorder = RepRepBorderView()
        
        header.addSubview(topBorder)
        topBorder.snp.makeConstraints { (view) in
            view.top.centerX.equalToSuperview()
            view.height.equalTo(1)
            view.width.equalToSuperview().multipliedBy(0.7)
        }

        //header.textLabel?.adjustsFontForContentSizeCategory = true
    }
}
