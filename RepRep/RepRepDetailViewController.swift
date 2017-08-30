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

class RepRepDetailViewController: UIViewController, RepRepOfficialButtonDelegate, UICollectionViewDelegate {
    
    let governmentOfficial: GovernmentOfficial
    let officialView = RepRepOfficialView()
    var collectionViewDriver: RepRepCollectionViewDriver!
    
    init(for official: GovernmentOfficial) {
        governmentOfficial = official
        super.init(nibName: nil, bundle: nil)
        officialView.official = official
        officialView.delegate = self
        getImage()
        getArticles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(officialView)
        edgesForExtendedLayout = []
        dump(governmentOfficial.channels)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.title = governmentOfficial.name

    }
    
    func getImage() {
        APIRequestManager.manager.getImage(APIEndpoint: governmentOfficial.photoURL ?? "") { (data) in
            if data != nil {
                DispatchQueue.main.async {
                    self.officialView.load(profileImage: UIImage(data: data!)!)
                }
            }
        }
    }
    
    func getArticles () {
        APIRequestManager.manager.getArticles(searchTerm: governmentOfficial.name) { (articles) in
            if articles != nil {
                DispatchQueue.main.async {
                    self.collectionViewDriver = RepRepCollectionViewDriver(articles: articles!)
                    self.officialView.articleCollectionView.dataSource = self.collectionViewDriver
                    self.officialView.articleCollectionView.delegate = self
                    self.officialView.articleCollectionView.reloadData()
                }
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let wvc = storyboard.instantiateViewController(withIdentifier: "wvc") as! WebViewController
//        self.selection = articles[indexPath.row].webURL
//        wvc.address = selection!
//        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkTime), userInfo: nil, repeats: true)
//        timer.fire()
    }

}
