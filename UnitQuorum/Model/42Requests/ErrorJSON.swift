//
//  ErrorJSON.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 5/24/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

class ErrorJSON: Error, Decodable
{
    var error: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "error_description"
    }
}
