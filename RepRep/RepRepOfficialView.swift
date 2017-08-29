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

class RepRepOfficialView: UIView {
    
    //MARK: Constants
    let imageHeightScaleFactor = 3
    let imageFrameInset = 4
    
    //MARK: Views
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "defaultProfile"))
    let profileContainerView = UIView()
    let emailButton = RepRepButton(type: .email)
    let phoneButton = RepRepButton(type: .phone)
    let borderView = RepRepBorderView()
    let partyIconView = RepRepPartyIconView()
    let nameLabel = RepRepLabel(type: .main)
    let articleCollectionView = UICollectionView()
    
    
    var official: GovernmentOfficial! {
        didSet {
            loadOfficial()
        }
    }
    
    weak var delegate: RepRepOfficialButtonDelegate!
    weak var collectionViewDataSource: UICollectionViewDataSource!
    weak var collectionViewDelegate: UICollectionViewDelegate!
    
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
        addSubview(profileContainerView)
        
        profileContainerView.snp.makeConstraints { (view) in
            view.top.equalToSuperview().inset(UIConstants.outerBorderInset)
            view.centerX.equalToSuperview()
            view.leading.greaterThanOrEqualToSuperview().inset(UIConstants.outerBorderInset)
            view.trailing.lessThanOrEqualToSuperview().inset(UIConstants.outerBorderInset)
            view.height.equalToSuperview().dividedBy(imageHeightScaleFactor)
        }
        
        profileContainerView.addSubview(profileImageView)
        profileContainerView.addSubview(borderView)

        profileImageView.snp.makeConstraints { (view) in
            view.top.equalToSuperview().inset(imageFrameInset)
            view.leading.greaterThanOrEqualToSuperview().inset(imageFrameInset)
            view.trailing.lessThanOrEqualToSuperview().inset(imageFrameInset)
        }
        
        //profileImageView.resizeImage()
        
        borderView.snp.makeConstraints { (view) in
            view.top.equalTo(profileImageView.snp.bottom).offset(imageFrameInset)
            view.height.equalTo(1)
            view.leading.bottom.trailing.equalToSuperview()
        }

        addSubview(nameLabel)

        nameLabel.snp.makeConstraints { (view) in
            view.top.equalTo(profileContainerView.snp.bottom).offset(imageFrameInset)
            view.leading.trailing.equalToSuperview().inset(imageFrameInset)
        }
        
        addSubview(emailButton)
        emailButton.snp.makeConstraints({ (view) in
            view.centerX.equalToSuperview().multipliedBy(0.5)
            view.top.equalTo(nameLabel.snp.bottom).offset(UIConstants.outerBorderInset)
        })

        addSubview(phoneButton)
        phoneButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(1.5)
            view.centerY.width.equalTo(emailButton)
        }
        
        addSubview(partyIconView)
        partyIconView.snp.makeConstraints { (view) in
            view.centerY.equalTo(phoneButton)
            view.centerX.equalToSuperview()
            view.height.width.equalTo(UIConstants.partyIconHeightHeight)
        }

        addSubview(articleCollectionView)
        articleCollectionView.snp.makeConstraints { (view) in
            view.top.equalTo(emailButton.snp.bottom).offset(UIConstants.innerBorderInset)
            view.leading.trailing.bottom.equalToSuperview().inset(UIConstants.innerBorderInset)
        }
    }
    
    func load(profileImage: UIImage) {
        profileImageView.image = profileImage
        //profileImageView.resizeImage()
    }
    
    private func loadOfficial () {
        partyIconView.addImageFor(party: official.party)
        nameLabel.text = official.name
        
        if let email = official.email {
            emailButton.isEnabled = true
            emailButton.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
        }
        
        if let phoneNumber = official.phone {
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

