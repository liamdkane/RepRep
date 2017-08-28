//
//  RepTableViewController.swift
//  RepRep
//
//  Created by Liam Kane on 8/19/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit

enum TableViewState {
    case empty
    case loading
    case populated
}


class RepTableViewController: UIViewController {

    //Constants
    fileprivate let repTitle = "Representative Repository"
    fileprivate let searchBarMinimizedLength: CGFloat = 60
    fileprivate let searchBarExtendedLength: CGFloat = {
        return UIScreen.main.bounds.width - 42
    }()
    private let statusBarSize: CGFloat = 20
    private let titleFontSize: CGFloat = 20
    
    //Views
    fileprivate var searchButton: UIBarButtonItem!
    fileprivate var searchBar: ZipSearchBar!
    private let empty = EmptyStateView()
    private let loading = LoadingStateView()
    
    private var state: TableViewState = .loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.repCream
        
        configureNavBar()
        configureGesture()
        
        switch state {
        case .empty:
            configureEmptyView()
        case .loading:
            configureLoadingView()
        case .populated:
            break
        }
    }
    
    private func configureNavBar() {
        
        guard let navBar = navigationController?.navigationBar else { return }
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        navBar.barTintColor = UIColor.repBlue
        let fontAttributes: [String: Any] = [NSForegroundColorAttributeName: UIColor.white,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: titleFontSize)]
        navBar.titleTextAttributes = fontAttributes
        toggleTitle(on: true)
        
        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed))
        searchButton.tintColor = .white
        navigationItem.leftBarButtonItem = searchButton
        
        searchBar = ZipSearchBar(frame: CGRect(x: 12, y:  0, width: 60, height: 44.0))
        navBar.addSubview(searchBar)
        searchBar.isHidden = true
        searchBar.delegate = self

    }
    
    @objc private func searchButtonPressed() {
        showSearchBar()
    }
    
    private func configureEmptyView() {
        view.addSubview(empty)
        empty.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(self.navigationController!.navigationBar.frame.height + statusBarSize)
            view.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureLoadingView() {
        view.addSubview(loading)
        loading.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(self.navigationController!.navigationBar.frame.height + statusBarSize)
            view.bottom.leading.trailing.equalToSuperview()
        }
    }
}


extension RepTableViewController: UISearchBarDelegate {
    fileprivate func showSearchBar() {
        searchBar.isHidden = false
        toggleTitle(on: false)
        navigationItem.setLeftBarButton(nil, animated: false)
        self.searchBar.prepareForFadeAnimation(fade: false)
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0.05, options: [], animations: {
            
            //
            let desiredWidth = UIScreen.main.bounds.width - 42
            self.adjustSearchBar(width: desiredWidth)
            
            self.searchBar.layoutIfNeeded()
        }) { (finished) in
            self.searchBar.becomeFirstResponder()
        }
    }
    
    fileprivate func hideSearchBar() {
        searchBar.prepareForFadeAnimation(fade: true)
        searchBar.textView?.endFloatingCursor()
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.adjustSearchBar(width: self.searchBarMinimizedLength)
        }, completion: { finished in
            self.searchBar.isHidden = true
            self.searchBar.resignFirstResponder()
            self.navigationItem.setLeftBarButton(self.searchButton, animated: false)
            self.toggleTitle(on: true)
        })
    }
    
    private func adjustSearchBar(width: CGFloat) {
        self.searchBar.frame = CGRect(x: self.searchBar.frame.origin.x,
                                      y: self.searchBar.frame.origin.y,
                                      width: width,
                                      height: self.searchBar.frame.height)
        self.searchBar.layoutIfNeeded()
    }
    
    fileprivate func toggleTitle(on: Bool) {
        navigationItem.title = on ? repTitle : ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //songViewModel.filter(by: searchText, sort: sortPreference)
    }
}

extension RepTableViewController: UIGestureRecognizerDelegate {
    
    func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle(tap:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
    }
    
    func handle(tap: UITapGestureRecognizer) {
        
        if searchBar.isFirstResponder {
            hideSearchBar()
        }
    }
}
