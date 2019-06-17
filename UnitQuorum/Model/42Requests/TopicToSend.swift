//
//  TopicToSend.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/17/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation



class TopicToSend : Encodable {
    let name : String
    
    let content : String
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case content = "content"
    }
    init(name : String, content : String)
    {
        self.name = name
        self.content = content
    }
}
