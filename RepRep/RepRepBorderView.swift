//
//  RepRepBorderView.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepBorderView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = .repRed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
