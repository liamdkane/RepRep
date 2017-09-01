//
//  Office.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import Foundation

class Office {
    let name: String
    let divisionId: String
    let levels: String?
    let roles: String?
    let indices: [Int]
    
    init(name: String, divisionId: String, levels: String?, roles: String?, indices: [Int]) {
        self.name = name
        self.divisionId = divisionId
        self.levels = levels
        self.roles = roles
        self.indices = indices
    }
    
    convenience init?(dict: [String: AnyObject]) {
        guard let name = dict["name"] as? String,
            let divisionId = dict["divisionId"] as? String,
            let indices = dict["officialIndices"] as? [Int] else { return nil }
        let levels = dict["levels"] as? [String]
        let roles = dict["roles"] as? [String]
        
        self.init(name: name, divisionId: divisionId, levels: levels?.joined(separator: ", "), roles: roles?.joined(separator: ", "), indices: indices)
    }
}
