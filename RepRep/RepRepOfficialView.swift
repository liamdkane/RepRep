//
//  RepRepOfficialView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import CoreGraphics

protocol EmailButtonDelegate: class {
    func didPressEmailButton()
}

protocol PhoneButtonDelegate: class {
    func didPressPhoneButton()
}

class RepRepOfficialView: UIView, UICollectionViewDelegateFlowLayout {
    
    //MARK: Constants
    let imageHeightScaleFactor = 3
    let imageFrameInset = 4
    let buttonBorder = 14
    let borderInset = 8
    
    //MARK: Views
    private let profileImageView = UIImageView(image: #imageLiteral(resourceName: "defaultProfile"))
    private let buttonContainerView = UIView()
    private let emailButton = RepRepButton(type: .email)
    private let phoneButton = RepRepButton(type: .phone)
    private let borderView = RepRepBorderView()
    private let partyIconView = RepRepPartyIconView()
    private let nameLabel = RepRepLabel(type: .main)
    let articleCollectionView = RepRepCollectionView()
    
    
    var official: GovernmentOfficial! {
        didSet {
            loadOfficial()
        }
    }
    
    weak var delegate: RepRepOfficialButtonDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.repCream
        profileImageView.contentMode = .scaleAspectFit
        nameLabel.text = "Name"
        configureConstraints()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureConstraints () {
        
        addSubview(profileImageView)
        addSubview(borderView)
        addSubview(partyIconView)
        addSubview(phoneButton)
        addSubview(emailButton)
        addSubview(nameLabel)
        addSubview(articleCollectionView)

        profileImageView.snp.makeConstraints { (view) in
            view.top.equalToSuperview().inset(UIConstants.innerBorderInset)
            view.leading.greaterThanOrEqualToSuperview().inset(UIConstants.outerBorderInset)
            view.trailing.lessThanOrEqualToSuperview().inset(UIConstants.outerBorderInset)
            view.height.equalToSuperview().dividedBy(imageHeightScaleFactor)
        }

        emailButton.snp.makeConstraints({ (view) in
            view.centerX.equalToSuperview().multipliedBy(0.5)
            view.top.equalTo(profileImageView.snp.bottom).offset(buttonBorder)
        })

        phoneButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(1.5)
            view.centerY.width.equalTo(emailButton)
        }
        
        partyIconView.snp.makeConstraints { (view) in
            view.centerY.equalTo(phoneButton)
            view.centerX.equalToSuperview()
            view.height.width.equalTo(UIConstants.partyIconHeightHeight)
        }
        
        borderView.snp.makeConstraints { (view) in
            view.top.equalTo(partyIconView.snp.bottom).offset(borderInset)
            view.height.equalTo(1)
            view.leading.trailing.equalToSuperview().inset(UIConstants.innerBorderInset)
        }

        nameLabel.snp.makeConstraints { (view) in
            view.top.equalTo(borderView.snp.bottom).offset(imageFrameInset)
            view.leading.trailing.equalToSuperview().inset(imageFrameInset)
        }
        
        articleCollectionView.snp.makeConstraints { (view) in
            view.top.equalTo(nameLabel.snp.bottom).offset(buttonBorder)
            view.bottom.equalToSuperview()
            view.leading.trailing.equalToSuperview().inset(UIConstants.innerBorderInset)
        }
    }
    
    func load(profileImage: UIImage) {
        profileImageView.image = profileImage
    }
    
    private func loadOfficial () {
        partyIconView.addImageFor(party: official.party)
        nameLabel.text = official.name
        
        if official.email != nil {
            emailButton.isEnabled = true
            emailButton.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
        }
        
        if official.phone != nil {
            phoneButton.isEnabled = true
            phoneButton.addTarget(self, action: #selector(phoneButtonPressed), for: .touchUpInside)
        }
    }
    
    //MARK: Button Actions
    func emailButtonPressed() {
        delegate.didPressEmailButton()
    }
    func phoneButtonPressed() {
        delegate.didPressPhoneButton()
    }
}

