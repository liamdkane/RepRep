//
//  RepRepArticleCollectionViewCell.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit

class RepRepArticleCollectionViewCell: UICollectionViewCell {
    
    static let id = "RepRepArticleCell"
    
    var articleImageView = UIImageView()
    var articleHeadlineLabel = RepRepLabel(type: .collectionCellLabel)
    
    var article: Article! {
        didSet {
            inputArticle()
        }
    }
    
    override func prepareForReuse() {
        articleImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        articleImageView.contentMode = .scaleToFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func inputArticle() {
        articleHeadlineLabel.text = article.headline
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.repGrey.withAlphaComponent(0), UIColor.repGrey]
        articleHeadlineLabel.layer.addSublayer(gradient)
        articleHeadlineLabel.layoutIfNeeded()
    }
    
    //MARK: - View Hierarchy and Constraints
    
    func configureConstraints () {
        contentView.addSubview(articleImageView)
        contentView.addSubview(articleHeadlineLabel)
        
        articleImageView.snp.makeConstraints { (view) in
            view.top.bottom.equalToSuperview()
            view.width.equalTo(UIConstants.collectionCellWidth)
        }
        
        articleHeadlineLabel.snp.makeConstraints { (view) in
            view.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //Views
}
