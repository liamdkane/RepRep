//
//  RepRepCollectionView.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepCollectionView: UICollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: CGFloat(UIConstants.innerBorderInset),
                                           bottom: 0,
                                           right: CGFloat(UIConstants.innerBorderInset))
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        super.init(frame: .zero, collectionViewLayout: layout)
        register(RepRepArticleCollectionViewCell.self, forCellWithReuseIdentifier: RepRepArticleCollectionViewCell.id)
        backgroundColor = UIColor.repCream
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
