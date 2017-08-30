//
//  Channel.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import Foundation

class Channel {
    let type: String
    let id: String
    
    init(type: String, id: String) {
        self.type = type
        self.id = id
    }
    
    convenience init?(_ dict: [String: String]) {
        guard let type = dict["type"],
            let id = dict["id"] else { return nil }
        self.init(type: type, id: id)
    }
}
