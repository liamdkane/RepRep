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
        title = "Articles"
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    func loadArticle() {
        
        let initialURL = URL(string: address)
        if let url = initialURL {
            let urlRequest = URLRequest(url: url)
            
            webView.loadRequest(urlRequest)
        }
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingView.removeFromSuperview()
    }
    
}
