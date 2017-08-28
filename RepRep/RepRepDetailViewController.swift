//
//  RepRepDetailViewController.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import MessageUI

typealias RepRepOfficialButtonDelegate = EmailButtonDelegate & PhoneButtonDelegate & MFMailComposeViewControllerDelegate

class RepRepDetailViewController: UIViewController, RepRepOfficialButtonDelegate {
    
    let governmentOfficial: GovernmentOfficial
    let officialView = RepRepOfficialView()
    
    init(for official: GovernmentOfficial) {
        governmentOfficial = official
        super.init(nibName: nil, bundle: nil)
        officialView.official = official
        officialView.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(officialView)
    }
    
    //MARK: RepRepOfficialButtonDelegate Methods
    
    func didPressPhoneButton() {
        let numbers = Set<Character>(arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
        let validPhoneNumber = governmentOfficial.phone!.characters.filter { numbers.contains($0) }
        let phoneNumber = String(validPhoneNumber)
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func didPressEmailButton() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([governmentOfficial.email!])
        mailComposerVC.setSubject("Letter from a Constituent")
        mailComposerVC.setMessageBody("\(governmentOfficial.name), \n\n ", isHTML: false)
        
        return mailComposerVC
    }    
}
