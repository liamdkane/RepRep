//
//  RepRepOfficialView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit


protocol EmailButtonDelegate: class {
    func didPressEmailButton()
}

protocol PhoneButtonDelegate: class {
    func didPressPhoneButton()
}

class RepRepOfficialView: UIView {
    
    let profileImage = RepRepProfileView()
    
    var official: GovernmentOfficial! {
        didSet {
            loadOfficial()
        }
    }
    
    weak var delegate: RepRepOfficialButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.repCream
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureConstraints () {
        
    }
    
    private func loadOfficial () {
        if let email = official.email {
            
        }
        
        if let phoneNumber = official.phone {
            
        }
    }
    
}
