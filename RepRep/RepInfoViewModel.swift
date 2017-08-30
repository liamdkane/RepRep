//
//  RepInfo.swift
//  Vote
//
//  Created by C4Q on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class RepInfoViewModel {
    var offices: [Office]
    var officials: [GovernmentOfficial]
    
    init(offices: [Office], officials: [GovernmentOfficial]) {
        //Data comes in reversed, idk why.
        self.offices = offices.reversed()
        self.officials = officials
    }
    
    static func getOfficials(zip: String, callback: @escaping (RepRepTableViewDriver) -> Void) {
        APIRequestManager.manager.getRepInfo(zip: zip) { repInfo in
            DispatchQueue.main.async {
                if let validRepInfo = repInfo {
                    callback(RepRepTableViewDriver(viewModel: validRepInfo))
                }
            }
        }
    }
    
    convenience init?(dict: [String: AnyObject]) {
        guard let officesDicts = dict["offices"] as? [[String: AnyObject]],
            let officialsDicts = dict["officials"] as? [[String: AnyObject]] else { return nil }
        var offices = [Office]()
        var officials = [GovernmentOfficial]()
        for officeDict in officesDicts {
            if let office = Office(dict: officeDict) {
                print("office made")
                offices.append(office)
            } else {
                print("office unaccounted for : \(officeDict)")
            }
        }
        
        for officialDict in officialsDicts {
            if let official = GovernmentOfficial(dict: officialDict) {
                print("official made")
                officials.append(official)
            } else {
                dump(officialDict)
            }
        }
        
        self.init(offices: offices, officials: officials)
    }
}






