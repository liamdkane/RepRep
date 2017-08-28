//
//  RepRepActivityIndicatorView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepActivityIndicatorView: UIActivityIndicatorView {

    init() {
        super.init(activityIndicatorStyle: .whiteLarge)
        backgroundColor = .clear
        color = UIColor.repBlue
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
