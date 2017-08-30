//
//  RepRepCollectionViewDriver.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepCollectionViewDriver: NSObject, UICollectionViewDataSource {
    
    let articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: RepRepArticleCollectionViewCell
        let article = articles[indexPath.row]
        if let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: RepRepArticleCollectionViewCell.id, for: indexPath) as? RepRepArticleCollectionViewCell {
            cell = dequedCell
        } else {
            cell = RepRepArticleCollectionViewCell()
        }

        if let url = article.thumbURL {
            APIRequestManager.manager.getImage(APIEndpoint: "https://static01.nyt.com/\(url)") {(data) in
                if let validData = data {
                    DispatchQueue.main.async {
                        cell.articleImageView.image = UIImage(data: validData)
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.repRed.withAlphaComponent(0.85)
        } else {
            cell.backgroundColor = UIColor.repBlue.withAlphaComponent(0.85)
        }
        
        cell.article = article
        
        return cell
    }
}
