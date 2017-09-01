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
        case saveDefaults
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                layer.borderColor = UIColor.repRed.cgColor
                setTitleColor(.repRed, for: .normal)
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
        backgroundColor = .white
        contentEdgeInsets = UIConstants.buttonInsets
        switch type {
        case .email:
            setTitle(UIConstants.emailButtonText, for: .normal)
        case .phone:
            setTitle(UIConstants.callButtonText, for: .normal)
        case .saveDefaults:
            isEnabled = true
            setTitle(UIConstants.saveDefaultsButtonText, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
