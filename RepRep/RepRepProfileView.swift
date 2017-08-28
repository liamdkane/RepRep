//
//  RepRepProfileView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepProfileView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.repCream
        layer.cornerRadius = UIConstants.roundCornerValue
        layer.borderColor = UIColor.repBlue.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
