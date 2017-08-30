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
        //layout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: CGFloat(UIConstants.innerBorderInset),
                                           right: 0)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIConstants.collectionCellWidth, height: 80)
        super.init(frame: .zero, collectionViewLayout: layout)
        register(RepRepArticleCollectionViewCell.self, forCellWithReuseIdentifier: RepRepArticleCollectionViewCell.id)
        backgroundColor = UIColor.repCream
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
