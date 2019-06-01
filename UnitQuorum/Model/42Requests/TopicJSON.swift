//
//  TopicJSON.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/1/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

class TopicJSON: Decodable {
        let id : Int
        let name : String
        let created_at : Date
        let updated_at : Date
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case created_at = "created_at"
            case updated_at = "updated_at"
        }


}


//    let author: Author?
//    let kind: String?
//    let pinnedAt, lockedAt, pinner, locker: String?
//    let messagesURL: String?
//    let message: Message?
//    let tags: [Tag]?
//
//        case id, name, author, kind
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case pinnedAt = "pinned_at"
//        case lockedAt = "locked_at"
//        case pinner, locker
//        case messagesURL = "messages_url"
//        case message, tags
