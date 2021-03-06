//
//  RepRepTableView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        register(RepRepTableViewCell.self, forCellReuseIdentifier: RepRepTableViewCell.id)
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = UIConstants.partyIconHeightHeight
        backgroundColor = .repCream
        //separatorInset = UIEdgeInsets.zero
        separatorStyle = .none
        layoutMargins = UIEdgeInsets.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
