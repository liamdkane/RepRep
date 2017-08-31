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
        header.tintColor = .clear
        header.textLabel?.textColor = .black
        header.textLabel?.backgroundColor = .repCream
        header.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        header.textLabel?.lineBreakMode = .byWordWrapping
        header.textLabel?.numberOfLines = 2
        header.textLabel?.textAlignment = .center
        
        let bottomBorder = RepRepBorderView()
        
        let headerTitle = UIView()
        headerTitle.backgroundColor = .repCream
        header.addSubview(headerTitle)
        header.sendSubview(toBack: headerTitle)
        headerTitle.snp.remakeConstraints { (view) in
            view.top.bottom.centerX.equalToSuperview()
            
            view.width.equalToSuperview().multipliedBy(UIConstants.collectionViewHeaderViewScaleFactor)
        }
        
        header.addSubview(bottomBorder)
        bottomBorder.snp.makeConstraints { (view) in
            view.bottom.centerX.equalToSuperview()
            view.height.equalTo(1)
            view.width.equalToSuperview().multipliedBy(UIConstants.collectionViewHeaderViewScaleFactor)
        }
        
        let topBorder = RepRepBorderView()
        
        header.addSubview(topBorder)
        topBorder.snp.makeConstraints { (view) in
            view.top.centerX.equalToSuperview()
            view.height.equalTo(1)
            view.width.equalToSuperview().multipliedBy(UIConstants.collectionViewHeaderViewScaleFactor)
        }

        //header.textLabel?.adjustsFontForContentSizeCategory = true
    }
}
