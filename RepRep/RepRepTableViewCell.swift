//
//  RepRepTableViewCell.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit

class RepRepTableViewCell: UITableViewCell {

    static let id = "RepRep"
    private let cellInset = 4
    
    var official: GovernmentOfficial! {
        didSet {
            self.loadOfficial()
        }
    }

    //MARK: - Views
    
    let nameLabel = RepRepLabel(type: .main)
    let partyIconImageView = RepRepPartyIconView()
    var arrowView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "arrow").withRenderingMode(.alwaysTemplate))
        view.tintColor = .repGrey
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .repCream
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - View Hierarchy and Constraints
    private func setupViewHierarchy () {
        contentView.addSubview(partyIconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(arrowView)
    }
    
    private func configureConstraints() {
        partyIconImageView.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview().offset(cellInset)
            view.bottom.equalToSuperview().inset(cellInset)
            view.height.width.equalTo(UIConstants.partyIconHeightHeight)
        }
        
        arrowView.snp.makeConstraints { (view) in
            view.centerY.equalToSuperview()
            view.trailing.equalToSuperview().inset(cellInset)
            view.height.width.equalTo(UIConstants.partyIconHeightHeight / 2)
        }
        
        nameLabel.snp.makeConstraints { (view) in
            view.centerY.centerX.equalToSuperview()
            view.leading.lessThanOrEqualTo(partyIconImageView.snp.trailing).offset(cellInset)
            view.trailing.lessThanOrEqualTo(arrowView.snp.leading).inset(-cellInset)
        }
    }
    
    //MARK: Content Managing
    private func loadOfficial() {
        nameLabel.text = official.name
        partyIconImageView.addImageFor(party: official.party)
    }
}
