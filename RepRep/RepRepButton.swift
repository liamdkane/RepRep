//
//  RepRepButton.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepButton: UIButton {
    
    enum RepRepButtonType {
        case phone
        case email
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                layer.borderColor = UIColor.repRed.cgColor
                setTitleColor(UIColor.repRed, for: .normal)
                layer.borderWidth = 2
            } else {
                layer.borderColor = UIColor.lightGray.cgColor
                setTitleColor(.lightGray, for: .normal)
                layer.borderWidth = 1
            }
        }
    }
    
    init(type: RepRepButtonType) {
        
        super.init(frame: .zero)
        isEnabled = false
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        switch type {
        case .email:
            setTitle("Email", for: .normal)
        case .phone:
            setTitle("Call", for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
