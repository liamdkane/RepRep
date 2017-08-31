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
        case main
        case detail
        case title
        case collectionCellLabel
    }
    
    init(type: LabelType) {
        super.init(frame: .zero)
        textAlignment = .center
        numberOfLines = 0
        minimumScaleFactor = 0.5
        
        switch type {
        case .main:
            textColor = .black
        case .detail:
            textColor = .repGrey
            font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        case .title:
            textColor = .repRed
            font = .boldSystemFont(ofSize: UIConstants.titleFontSize)
        case .collectionCellLabel:
            font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            backgroundColor = .repCream
            textColor = .repGrey
            alpha = 0.7
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
