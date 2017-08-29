//
//  RepRepCollectionViewDriver.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepCollectionViewDriver: NSObject, UICollectionViewDataSource {
    
    let articles = [Article]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: RepRepArticleCollectionViewCell
        if let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: RepRepArticleCollectionViewCell.id, for: indexPath) as? RepRepArticleCollectionViewCell {
            cell = dequedCell
        } else {
            cell = RepRepArticleCollectionViewCell()
        }

        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.repRed.withAlphaComponent(0.85)
        } else {
            cell.backgroundColor = UIColor.repBlue.withAlphaComponent(0.85)
        }
        
        cell.article = articles[indexPath.row]
        
        return cell
    }
}
