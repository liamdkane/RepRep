//
//  RepRepDefaultButtonView.swift
//  RepRep
//
//  Created by Liam Kane on 8/31/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

protocol DefaultButtonDelegate: class {
    func defaultButtonPressed(save: Bool)
}

class RepRepDefaultButtonView: UIView {
    private var defaultButton = RepRepButton(type: .saveDefaults)
    private var save = false
    
    weak var delegate: DefaultButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultButton.addTarget(self, action: #selector(defaultButtonPressed), for: .touchUpInside)
        backgroundColor = UIColor.repCream.withAlphaComponent(UIConstants.fadedRepColour)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView () {
        addSubview(defaultButton)
        
        defaultButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().inset(UIConstants.saveDefaultsButtonInset)
        }
    }
    
    func defaultButtonPressed () {
        save = !save
        if save {
            defaultButton.backgroundColor = .repRed
            defaultButton.setTitleColor(.white, for: .normal)
        } else {
            defaultButton.backgroundColor = .white
            defaultButton.setTitleColor(.repRed, for: .normal)

        }
        delegate.defaultButtonPressed(save: save)
    }
}
