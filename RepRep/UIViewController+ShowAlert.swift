//
//  UIViewController+ShowAlert.swift
//  RepRep
//
//  Created by Liam Kane on 8/31/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    
    func makeDefaultOKAlert() {
        makeCustomOKAlert(title: UIConstants.defaultAlertTitle, message: UIConstants.defaultAlertMessage)
    }
    
    func makeCustomOKAlert(title: String, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel) { (_) in
            if let completionAction = completion {
                completionAction()
            }
        }
        alert.view.tintColor = .repRed
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
}
