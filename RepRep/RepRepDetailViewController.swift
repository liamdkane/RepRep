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

class RepRepDetailViewController: UIViewController {
    
    fileprivate let governmentOfficial: GovernmentOfficial
    private let officialView = RepRepOfficialView()
    fileprivate var collectionViewDriver: RepRepCollectionViewDriver!
    private let detailTitle: String
    
    init(for official: GovernmentOfficial, title: String) {
        governmentOfficial = official
        detailTitle = title
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
        navigationController?.topViewController?.title = detailTitle
        navigationItem.backBarButtonItem?.title = nil
        edgesForExtendedLayout = []
        dump(governmentOfficial.channels)
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func getImage() {
        APIRequestManager.manager.getImage(APIEndpoint: governmentOfficial.photoURL ?? "") { (data) in
            if data != nil {
                DispatchQueue.main.async {
                    self.officialView.load(profileImage: UIImage(data: data!)!)
                }
            }
        }
    }
    
    private func getArticles () {
        APIRequestManager.manager.getArticles(searchTerm: governmentOfficial.name) { articles, error in
            if error != nil {
                //makeCustomOKAlert(title: error, message: error.localizedDescription)
            }
            
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
}

extension RepRepDetailViewController: RepRepOfficialButtonDelegate {
    
    
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
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([governmentOfficial.email!])
        mailComposerVC.setSubject("Letter from a Constituent")
        mailComposerVC.setMessageBody("\(governmentOfficial.name), \n\n ", isHTML: false)
        
        return mailComposerVC
    }
}

extension RepRepDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webVC = WebViewController()
        let cell = collectionView.cellForItem(at: indexPath) as! RepRepArticleCollectionViewCell
        webVC.address = cell.article.webURL
        
        navigationController?.pushViewController(webVC, animated: true)
    }

}
