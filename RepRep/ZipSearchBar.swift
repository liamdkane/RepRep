//
//  ZipSearchBar.swift
//  RepRep
//
//  Created by Liam Kane on 8/21/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import Foundation

import UIKit

class ZipSearchBar: UISearchBar {
    var textView: UITextField? {
        if let subView = self.subviews.first {
            if let textField = subView.subviews.first(where: { $0 is UITextField }) as? UITextField {
                return textField
            }
        }
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //keyboardType = .
        contentMode = .left
        textView?.textColor = .black
        tintColor = .white
        removeLayerAnimationsRecursively()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //I was noticing some clipping when the cancel button and the test was showing. I tried taking out the string and storing it in the VC before and after animations, but there was still a clip. There is still a bit of a clip, I have a strong suspicion it is due to the nature of SearchBar (minorly conflicting default animations). If I joined the team I would have a direct in debugging that from the get go :D, also XCode doesn't mind emojis so 😅.
    func prepareForFadeAnimation(fade: Bool) {
        if let textView = textView {
            textView.textColor = fade ? .clear : .black
            textView.subviews.forEach({ (view) in
                if let cancelButton = view as? UIButton {
                    cancelButton.imageView?.isHidden = fade
                }
            })
        }
        layoutIfNeeded()
    }
}


extension UIView {
    
    func removeLayerAnimationsRecursively() {
        layer.removeAllAnimations()
        subviews.forEach { $0.removeLayerAnimationsRecursively() }
    }
}
