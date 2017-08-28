//
//  RepLabel.swift
//  RepRep
//
//  Created by Liam Kane on 8/27/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
