//
//  RepRepSectionHeader.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

struct RepRepSectionHeaderConstructor {
    static func update(header: UITableViewHeaderFooterView) {
        header.tintColor = UIColor.repRed
        header.textLabel?.textColor = UIColor.repCream
        header.textLabel?.lineBreakMode = .byWordWrapping
        header.textLabel?.numberOfLines = 2
        header.textLabel?.textAlignment = .center
        header.textLabel?.adjustsFontForContentSizeCategory = true
    }
}
