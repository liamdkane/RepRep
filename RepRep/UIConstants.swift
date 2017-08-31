//
//  UIConstants.swift
//  RepRep
//
//  Created by Liam Kane on 8/30/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

struct UIConstants {
    
    //MARK: Border Values
    static let innerBorderInset = 24
    static let outerBorderInset = 44
    
    //MARK: Navigation Bar values
    static let titleFontSize: CGFloat = 20
    static let repTitle = "Representative Repository"

    //MARK: Party Icon Values
    static let roundCornerValue: CGFloat = 20
    static let partyIconHeightHeight: CGFloat = 40
    
    //MARK: Colour Alphas
    static let collectionLabelAlpha: CGFloat = 0.7
    static let fadedRepColour: CGFloat = 0.85
    
    //MARK: Button Specific Values
    static let buttonInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
    static let saveDefaultsButtonText = "Default ZIP Code"
    static let emailButtonText = "Email"
    static let searchButtonText = "Search"
    static let callButtonText = "Call"

    //MARK: Collection Cell Size values
    static let collectionViewHeaderViewScaleFactor = 0.7
    static let collectionCellWidth = UIScreen.main.bounds.width / 2 - CGFloat(UIConstants.innerBorderInset + 12)
    
    //MARK: Searchbar values
    static let searchBarAnimationDuration = 0.3
    static let searchBarMinimizedLength: CGFloat = 60
    static let searchBarExtendedLength: CGFloat = UIScreen.main.bounds.width - 90
    
    //MARK: Save Defaults Inset
    static let saveDefaultsButtonInset = 12
    
    //MARK: Alert Constants
    static let defaultAlertTitle = "Error"
    static let defaultAlertMessage = "Something went wrong, please try again"
    static let invalidZipAlertMessage = "Invalid Zipcode"

}
