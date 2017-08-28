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
    //MARK: - Views
    
    let nameLabel = RepRepLabel(type: .main)
    //let partyIconImageView = UIImageView()
    var partyIconImageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.backgroundColor = UIColor.repCream
        view.layer.cornerRadius = UIConstants.roundCornerValue
        view.layer.borderColor = UIColor.repBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()

//    let
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var official: GovernmentOfficial! {
        didSet {
            self.loadOfficial()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - View Hierarchy and Constraints
    
    private func setupViewHierarchy () {
        self.contentView.addSubview(partyIconImageView)
        self.contentView.addSubview(nameLabel)
    }
    
    private func configureConstraints() {
        partyIconImageView.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview().offset(cellInset)
            view.bottom.equalToSuperview().inset(cellInset)
            view.height.width.equalTo(UIConstants.cellHeight)
        }
        
        nameLabel.snp.makeConstraints { (view) in
            view.leading.equalTo(partyIconImageView.snp.trailing).offset(UIConstants.innerBorderInset)
            view.centerY.equalToSuperview()
            view.trailing.equalToSuperview().inset(cellInset)
        }
    }
    
    //MARK: Content Managing
    
    func loadOfficial() {
        self.nameLabel.text = self.official.name
        
        switch self.official.party {
        case _ where self.official.party.contains("Democrat"):
            self.partyIconImageView.image = #imageLiteral(resourceName: "democrat")
        case "Republican":
            self.partyIconImageView.image = #imageLiteral(resourceName: "republican")
        default:
            self.partyIconImageView.image = #imageLiteral(resourceName: "independent")
        }
    }
}
