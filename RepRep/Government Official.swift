//
//  Government Official.swift
//  RepRep
//
//  Created by Liam Kane on 8/29/17.
//  Copyright © 2017 RepresentativeReputation. All rights reserved.
//

import Foundation


class GovernmentOfficial {
    
    enum PoliticalParty {
        case democrat
        case republican
        case independent
        
        init(_ string: String) {
            switch string {
            case _ where string.contains("Democrat"):
                self = .democrat
            case "Republican":
                self = .republican
            default:
                self = .independent
            }
        }
    }
    
    var name: String
    var party: PoliticalParty
    var address: Address?
    var phone: String?
    var officeURL: String?
    var photoURL: String?
    var channels: [Channel]?
    var email: String?
    
    init(name: String, address: Address?, party: PoliticalParty, phone: String?, officeURL: String?, photoURL: String?, channels: [Channel]?, email: String?) {
        self.name = name
        self.party = party
        self.address = address
        self.phone = phone
        self.officeURL = officeURL
        self.photoURL = photoURL
        self.channels = channels
        self.email = email
    }
    
    convenience init?(dict: [String: AnyObject]) {
        guard let name = dict["name"] as? String,
            let party = dict["party"] as? String else { return nil }
        
        var officeURL: String? = nil
        if let urls = dict["urls"] as? [String] {
            officeURL = urls.first
        }
        
        var address: Address? = nil
        if let addressDicts = dict["address"] as? [[String: String]],
            let addressDict = addressDicts.first {
            address = Address(addressDict)
        }
        
        var phone: String? = nil
        if let phones = dict["phones"] as? [String] {
            phone = phones.first
        }
        
        var channels: [Channel]? = nil
        
        if let channelDicts = dict["channels"] as? [[String: String]] {
            channels = []
            for channelDict in channelDicts {
                if let channel = Channel(channelDict) {
                    print("channel made")
                    channels!.append(channel)
                }
            }
        }
        let photoURL = dict["photoUrl"] as? String
        var email: String? = nil
        if let emails = dict["emails"] as? [String] {
            email = emails.first
        }
        
        
        self.init(name: name, address: address, party: PoliticalParty(party), phone: phone, officeURL: officeURL, photoURL: photoURL, channels: channels, email: email)
    }
    
}
