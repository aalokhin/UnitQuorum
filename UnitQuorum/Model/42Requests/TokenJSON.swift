//
//  TokenJSON.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 5/24/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

class TokenJSON: Decodable {
    
    var token: String?
    var expiresIn: Int?
    var createdAt: Date?
    
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case expiresIn = "expires_in"
        case createdAt = "created_at"
    }
    

}
