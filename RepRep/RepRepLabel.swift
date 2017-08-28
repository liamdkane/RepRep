//
//  RepLabel.swift
//  RepRep
//
//  Created by Liam Kane on 8/27/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepLabel: UILabel {

    
    enum LabelType {
        case main, detail, title
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
        case .title:
            textColor = UIColor.repRed
            font = .boldSystemFont(ofSize: UIConstants.titleFontSize)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}