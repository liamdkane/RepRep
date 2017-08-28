//
//  LoadingView.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class LoadingStateView: UIVisualEffectView {

    private let containerView = RepRepContainerView()
    private let activityIndicator = RepRepActivityIndicatorView()
    private let loadingLabel = RepLabel(type: .main)
    
    init() {
        let blurView = UIBlurEffect(style: .light)
        super.init(effect: blurView)
        
        configureConstraints()
        activityIndicator.startAnimating()
        loadingLabel.text = "Loading..."
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (view) in
            view.top.centerX.equalToSuperview().inset(UIConstants.outerBorderInset)
        }
        
        containerView.addSubview(loadingLabel)
        containerView.addSubview(activityIndicator)
        
        loadingLabel.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview().inset(UIConstants.innerBorderInset)
        }
        
        activityIndicator.snp.makeConstraints { (view) in
            view.top.equalTo(loadingLabel.snp.bottom).offset(UIConstants.innerBorderInset)
            view.leading.trailing.bottom.equalToSuperview().inset(UIConstants.innerBorderInset)
        }
    }
}
