//
//  StarImageView.swift
//  RepRep
//
//  Created by Liam Kane on 8/27/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit

//Ultimately unused, but still a part of the idea.


/*
class StarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var frame: CGRect {
        didSet {
            if !(frame == .zero) {
                createStarViews()
            }
        }
    }
    
    private let starSize = 40
    private let starSpacing: CGFloat = 8
    
    func createStarViews() {
        let number = Int(frame.width) / starSize
        let remainder = frame.width - CGFloat(number * starSize)
        let spacingValue = remainder / CGFloat(number)
        
        for i in 0..<number {
            let imageView = UIImageView()
            addSubview(imageView)
            
            //adding on half the spacing value will center the views. I suspect there is a better way to do this.
            let spacing = CGFloat(i) * spacingValue + spacingValue/2
            
            let offset = CGFloat(i * starSize) + spacing
            imageView.snp.makeConstraints({ (view) in
                view.top.bottom.equalToSuperview()
                view.width.height.equalTo(self.starSize)
                view.leading
                    .equalToSuperview()
                    .offset(offset)
            })
            
            let isEven = i % 2 == 0
            imageView.image = isEven
                ? #imageLiteral(resourceName: "Star Empty").withRenderingMode(.alwaysTemplate)
                : #imageLiteral(resourceName: "Star Filled").withRenderingMode(.alwaysTemplate)
            
            imageView.tintColor = UIColor.repRed
            
            layoutIfNeeded()
        }
    }

}
*/
