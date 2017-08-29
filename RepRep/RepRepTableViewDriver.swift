//
//  RepRepTableViewDataSource.swift
//  RepRep
//
//  Created by Liam Kane on 8/28/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import UIKit

class RepRepTableViewDriver: NSObject, UITableViewDataSource {
    
    private let repInfoViewModel: RepInfoViewModel
    
    init(viewModel: RepInfoViewModel) {
        repInfoViewModel = viewModel
        dump(repInfoViewModel)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return repInfoViewModel.offices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repInfoViewModel.offices[section].indices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: RepRepTableViewCell
        if let dequedCell = tableView.dequeueReusableCell(withIdentifier: RepRepTableViewCell.id, for: indexPath) as? RepRepTableViewCell {
            cell = dequedCell
        } else {
            cell = RepRepTableViewCell(style: .default, reuseIdentifier: RepRepTableViewCell.id)
        }
        
        let officialIndex = repInfoViewModel.offices[indexPath.section].indices[indexPath.row]
        let currentOfficial = repInfoViewModel.officials[officialIndex]
        cell.official = currentOfficial
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return repInfoViewModel.offices[section].name
    }
}
