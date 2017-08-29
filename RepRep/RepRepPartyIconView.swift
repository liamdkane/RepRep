//
//  RepRepProfileView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepPartyIconView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.repCream
        contentMode = .center
        layer.cornerRadius = UIConstants.roundCornerValue
        layer.borderColor = UIColor.repBlue.cgColor
        layer.borderWidth = 1
    }
    
    func addImageFor(party: GovernmentOfficial.PoliticalParty) {
        switch party {
        case .democrat:
            image = #imageLiteral(resourceName: "democrat")
        case .republican:
            image = #imageLiteral(resourceName: "republican")
        case .independent:
            image = #imageLiteral(resourceName: "independent")
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
