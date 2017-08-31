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
    fileprivate let defaultsKey = "ZipCode"
    
    //MARK: Views
    fileprivate var searchIconButton: UIBarButtonItem!
    fileprivate var searchButton: UIBarButtonItem!
    fileprivate var searchBar: ZipSearchBar!
    fileprivate var defaultView: RepRepDefaultButtonView!
    private let empty = EmptyStateView()
    private let loading = LoadingStateView()
    fileprivate let tableView = RepRepTableView()
    fileprivate var saveToDefaults: Bool = false
    
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
        
        view.backgroundColor = .repCream
        edgesForExtendedLayout = []
        configureNavBar()
        configureGesture()
        update(state)
        checkDefaults()
    }
    
    
    //MARK: UI Functions
    private func configureNavBar() {
        
        guard let navBar = navigationController?.navigationBar else { return }
        
        //UIApplication.shared.statusBarStyle = .lightContent
        
        navBar.barTintColor = .repBlue
        let fontAttributes: [String: Any] = [NSForegroundColorAttributeName: UIColor.white,
                                             NSFontAttributeName: UIFont.systemFont(ofSize: UIConstants.titleFontSize)]
        navBar.isTranslucent = false
        navBar.titleTextAttributes = fontAttributes
        toggleTitle(on: true)
        
        searchButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.plain, target: self, action: #selector(searchButtonPressed))
        searchButton.tintColor = .white
        
        searchIconButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchIconButtonPressed))
        searchIconButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = searchIconButton
        
        searchBar = ZipSearchBar(frame: CGRect(x: 12, y:  0, width: 60, height: 44.0))
        navBar.addSubview(searchBar)
        searchBar.isHidden = true
        searchBar.delegate = self
    }
    
    @objc private func searchIconButtonPressed() {
        showSearchBar()
    }
    
    @objc private func searchButtonPressed() {
        hideSearchBar { [weak self] in
            if self!.searchBar.text?.characters.count == 5 {
                self!.handleSaveToDefaultsValue()
                self!.getOfficials(zip: self!.searchBar.text!)
            } else {
                self!.makeCustomOKAlert(title: UIConstants.defaultAlertTitle, message: UIConstants.invalidZipAlertMessage)
            }
        }
    }
    
    fileprivate func getOfficials(zip: String) {
        self.state = .loading
        RepInfoViewModel.getOfficials(zip: zip) { [weak self] repInfo, error in
            if let validRepInfo = repInfo {
                let driver = RepRepTableViewDriver(viewModel: validRepInfo)
                self!.tableViewDriver = driver
                self!.tableView.reloadData()
            }
            if error != nil {
                self!.makeCustomOKAlert(title: UIConstants.defaultAlertTitle, message: error!.localizedDescription)
            }
        }

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
        navigationItem.setRightBarButton(searchButton, animated: true)
        searchBar.prepareForFadeAnimation(fade: false)
        presentDefaultView()
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: UIConstants.searchBarAnimationDuration, delay: 0.05, options: [], animations: {
            
            let desiredWidth = UIConstants.searchBarExtendedLength
            self.adjustSearchBar(width: desiredWidth)
            self.searchBar.layoutIfNeeded()
            
        }) { (finished) in
            self.searchBar.becomeFirstResponder()
        }
    }
    
    fileprivate func hideSearchBar(completion: @escaping () -> Void) {
        searchBar.prepareForFadeAnimation(fade: true)
        searchBar.textView?.endFloatingCursor()
        navigationItem.setRightBarButton(nil, animated: true)
        defaultView.removeFromSuperview()
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: UIConstants.searchBarAnimationDuration,
                                                       delay: 0,
                                                       options: [],
                                                       animations: {
                                                        self.adjustSearchBar(width: UIConstants.searchBarMinimizedLength)
                                                        
        }, completion: { finished in
            self.searchBar.isHidden = true
            self.searchBar.resignFirstResponder()
            self.navigationItem.setLeftBarButton(self.searchIconButton, animated: false)
            self.toggleTitle(on: true)
            completion()
        })
    }
    
    private func adjustSearchBar(width: CGFloat) {
        searchBar.frame = CGRect(x: self.searchBar.frame.origin.x,
                                 y: self.searchBar.frame.origin.y,
                                 width: width,
                                 height: self.searchBar.frame.height)
        searchBar.layoutIfNeeded()
    }
    
    fileprivate func toggleTitle(on: Bool) {
        navigationItem.title = on ? UIConstants.repTitle : ""
    }
}

extension RepRepViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        RepRepSectionHeaderConstructor.update(header: header)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RepRepTableViewCell
        let officeTitle = tableViewDriver.repInfoViewModel.offices[indexPath.section].name
        let dtvc = RepRepDetailViewController(for: cell.official, title: officeTitle)
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
            hideSearchBar{}
        } else {
            tap.cancelsTouchesInView = false
        }
    }
}

extension RepRepViewController: DefaultButtonDelegate {
    
    func presentDefaultView() {
        defaultView = RepRepDefaultButtonView()
        view.addSubview(defaultView)
        
        defaultView.delegate = self
        defaultView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
            
        }
    }
    
    func defaultButtonPressed(save: Bool) {
        saveToDefaults = save
    }
    
    func handleSaveToDefaultsValue () {
        if saveToDefaults {
            let defaults = UserDefaults.standard
            defaults.set(searchBar.text, forKey: defaultsKey)
        }
    }
    
    func checkDefaults () {
        let defaults = UserDefaults.standard
        if let zipCode = defaults.string(forKey: defaultsKey) {
            getOfficials(zip: zipCode)
        }
    }
}
