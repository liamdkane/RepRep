//
//  RepLabel.swift
//  RepRep
//
//  Created by Liam Kane on 8/27/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepLabel: UILabel {

    
    enum LabelType {
        case main, detail
    }
    
    init(type: LabelType) {
        super.init(frame: .zero)
        textAlignment = .center
        numberOfLines = 0
        minimumScaleFactor = 0.5
        
        switch type {
        case .main:
            textColor = UIColor.black
        case .detail:
            textColor = UIColor.repGrey
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
