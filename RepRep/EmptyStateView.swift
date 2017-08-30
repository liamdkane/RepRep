//
//  EmptyStateView.swift
//  RepRep
//
//  Created by Liam Kane on 8/22/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit


class EmptyStateView: UIView {
    
    private var instructionsContainerView = RepRepContainerView()
    private var instructionsLabel = RepRepLabel(type: .main)
    private var reminderLabel = RepRepLabel(type: .detail)
    private var iconImageView = UIImageView(image: #imageLiteral(resourceName: "buildingPhone"))
    
    private let starSize = 32
    private let starSpacing: CGFloat = 6
    private let labelScale = 0.7
    
    private let instructionsText = "Please press the search icon and enter your zipcode to find information on representatives in your area."
    
    private let reminderText = "Feel free to set a default location to not see this prompt again."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        populateLabel()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func populateLabel() {
        addSubview(instructionsContainerView)

        instructionsContainerView.addSubview(instructionsLabel)
        instructionsContainerView.addSubview(iconImageView)
        instructionsContainerView.addSubview(reminderLabel)
        
        instructionsLabel.text = instructionsText
        reminderLabel.text = reminderText
    }
    
    private func configureConstraints() {
        instructionsContainerView.snp.makeConstraints { (view) in
            view.centerX.centerY.equalToSuperview()
            view.top.leading.trailing.equalToSuperview().inset(UIConstants.outerBorderInset)
            //view..equalToSuperview().multipliedBy(labelScale)
        }
        
        iconImageView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().inset(UIConstants.innerBorderInset)
        }
        
        instructionsLabel.snp.makeConstraints { (view) in
            view.top.equalTo(iconImageView.snp.bottom).offset(UIConstants.innerBorderInset)
            view.leading.trailing.equalToSuperview().inset(UIConstants.innerBorderInset)
            
        }
        
        reminderLabel.snp.makeConstraints { (view) in
            view.top.equalTo(instructionsLabel.snp.bottom).offset(UIConstants.innerBorderInset)
            view.leading.trailing.equalToSuperview().inset(UIConstants.innerBorderInset)
        }

        
        configureStarViews()
    }
    
    func configureStarViews() {
        
        //TODO: Rework this to be more dynamic. The problem I was having was that I couldn't access the size of the container view/when I bypassed that it wouldn't center correctly.
        let rightStar = UIImageView(image: #imageLiteral(resourceName: "Star Empty").withRenderingMode(.alwaysTemplate))
        let leftStar = UIImageView(image: #imageLiteral(resourceName: "Star Empty").withRenderingMode(.alwaysTemplate))
        let middleStar = UIImageView(image: #imageLiteral(resourceName: "Star Filled").withRenderingMode(.alwaysTemplate))
        
        let stars = [rightStar, leftStar, middleStar]
        stars.forEach {
            instructionsContainerView.addSubview($0)
            $0.tintColor = UIColor.repRed
        }
        
        middleStar.snp.makeConstraints { (view) in
            view.top.greaterThanOrEqualTo(reminderLabel.snp.bottom).offset(UIConstants.innerBorderInset)
            view.width.height.equalTo(starSize)
            view.centerX.equalToSuperview()
            view.bottom.equalToSuperview().inset(UIConstants.innerBorderInset)
        }
        
        leftStar.snp.makeConstraints { (view) in
            view.centerY.height.width.equalTo(middleStar)
            view.trailing.equalTo(middleStar.snp.leading).offset(-starSpacing)
        }
        
        rightStar.snp.makeConstraints { (view) in
            view.centerY.height.width.equalTo(middleStar)
            view.leading.equalTo(middleStar.snp.trailing).offset(starSpacing)
        }

    }

}
