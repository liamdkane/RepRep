//
//  RepTableViewController.swift
//  RepRep
//
//  Created by Liam Kane on 8/19/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit
import SnapKit

class RepRepViewController: UIViewController {
    
    enum TableViewState {
        case empty
        case loading
        case populated
    }
    
    //MARK: Constants
    fileprivate let repTitle = "Representative Repository"
    fileprivate let searchBarMinimizedLength: CGFloat = 60
    fileprivate let searchBarExtendedLength: CGFloat = {
        return UIScreen.main.bounds.width - 42
    }()
    
    //MARK: Views
    fileprivate var searchButton: UIBarButtonItem!
    fileprivate var searchBar: ZipSearchBar!
    private let empty = EmptyStateView()
    private let loading = LoadingStateView()
    fileprivate let tableView = RepRepTableView()
    
    //MARK: Properties
    fileprivate var state: TableViewState = .empty {
        didSet {
            update(state)
        }
    }
    fileprivate var tableViewDriver: RepRepTableViewDriver! {
        didSet {
            state = .populated
        }
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.repCream
        edgesForExtendedLayout = []
        configureNavBar()
        configureGesture()
        update(state)
    }
    
    
    //MARK: UI Functions
    private func configureNavBar() {
        
        guard let navBar = navigationController?.navigationBar else { return }
        
        //UIApplication.shared.statusBarStyle = .lightContent
        
        navBar.barTintColor = UIColor.repBlue
        let fontAttributes: [String: Any] = [NSForegroundColorAttributeName: UIColor.white,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: UIConstants.titleFontSize)]
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
    
    private func update(_ state: TableViewState) {
        switch state {
        case .empty:
            configureView(empty)
        case .loading:
            tableView.removeFromSuperview()
            configureView(loading)
        case .populated:
            
            empty.removeFromSuperview()
            loading.removeFromSuperview()
            configureView(tableView)
            tableView.delegate = self
            tableView.dataSource = tableViewDriver
        }
    }
}

extension RepRepViewController: UISearchBarDelegate {
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
        state = .loading
        hideSearchBar()
        if searchBar.text?.characters.count == 5 {
            RepInfoViewModel.getOfficials(zip: searchBar.text!) { driver in
                self.tableViewDriver = driver
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

extension RepRepViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        RepRepSectionHeaderConstructor.update(header: header)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RepRepTableViewCell
        let dtvc = RepRepDetailViewController(for: cell.official)
        navigationController?.pushViewController(dtvc, animated: true)
    }
}

extension RepRepViewController: UIGestureRecognizerDelegate {
    
    fileprivate func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle(tap:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc private func handle(tap: UITapGestureRecognizer) {
        if searchBar.isFirstResponder {
            tap.cancelsTouchesInView = true
            hideSearchBar()
        } else {
            tap.cancelsTouchesInView = false
        }
    }
}
