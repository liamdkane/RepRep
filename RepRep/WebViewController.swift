//
//  WebViewController.swift
//  RepRep
//
//  Created by Liam Kane on 8/30/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit
import WebKit
import AudioToolbox


class WebViewController: UIViewController, UIWebViewDelegate {
    
    var loadingView = LoadingStateView()
    var webView = UIWebView()

    var article: Article? {
        didSet {
            loadArticle()
        }
    }
    
    var address: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        configureView(webView)
        configureView(loadingView)
        webView.delegate = self
        
        loadArticle()
    }
    
    func configureNavBar() {
        let customBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backArrow"), style: .plain, target: self,
                                               action: #selector(backButtonPressed))
        navigationItem.setLeftBarButton(customBackButton, animated: true)
        title = "Article"
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func loadArticle() {
        
        let initialURL = URL(string: address)
        if let url = initialURL {
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest)
        }
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        makeCustomOKAlert(title: UIConstants.defaultAlertTitle, message: error.localizedDescription)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingView.removeFromSuperview()
    }
    
}
