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
    
    
    let created_at : String
    let updated_at : String
    //IMportsnyt ====================+> we have to convert it to StrDateing later with convertDate
//       let created_at : Date
//       let updated_at : Date
    
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
           case created_at = "created_at"
           case updated_at = "updated_at"
        }
    
    required init(from decoder: Decoder) throws {
        //  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Decodes the unkeyed array of self objects !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try values.decode(Int.self, forKey: .id))
        self.name = (try values.decode(String.self, forKey: .name))
        
       
    
        
        self.created_at = (try values.decode(String.self, forKey: .created_at))
        self.updated_at = (try values.decode(String.self, forKey: .updated_at))

        //self.created_at = _createdAt?.toDate(with: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        
        //self.updated_at = (try values.decode(String.self, forKey: .updated_at))
        //self.updated_at = _updatedAt.toDate(with: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
        
    
}

class Author: Decodable {
    let id: Int?
    let login: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case url
    }
}


    func convertDate(dateStr : String) -> Date
        {
            //let isoDate = "2016-04-14T10:44:00+0000"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            
            // set locale to reliable US_POSIX
            let retDate = dateFormatter.date(from : dateStr)!
            return retDate
            
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



// ----------- AUTHOR ------------------------
//required init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//    self.id = (try? values.decode(Int.self, forKey: .id))
//    self.login = (try? values.decode(String.self, forKey: .login))
//    self.url = (try? values.decode(String.self, forKey: .url))
//}

