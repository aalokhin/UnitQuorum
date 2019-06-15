//
//  TopicJSON.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/1/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

func convertDate(dateStr : String) -> Date
{
    //let isoDate = "2016-04-14T10:44:00+0000"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    
    // set locale to reliable US_POSIX
    let retDate = dateFormatter.date(from : dateStr)!
    return retDate
    
}

class TopicJSON: Decodable {
        let id : Int
        let name : String
        let message: Message
    
    
    let created_at : String
    let updated_at : String
    // IMportant ====================+> we have to convert it to StrDateing later with convertDate
//       let created_at : Date
//       let updated_at : Date
    
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
           case created_at = "created_at"
           case updated_at = "updated_at"
            case message = "message"
        }
    
    required init(from decoder: Decoder) throws {
        //  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Decodes the unkeyed array of self objects !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try values.decode(Int.self, forKey: .id))
        self.name = (try values.decode(String.self, forKey: .name))
        
       self.message = (try values.decode(Message.self, forKey: .message))
    
        
        self.created_at = (try values.decode(String.self, forKey: .created_at))
        self.updated_at = (try values.decode(String.self, forKey: .updated_at))

    }
        
    
}

class Message: Decodable {
    
    let id : Int
    let content: Content
    
    enum CodingKeys: String, CodingKey {
        case id, content
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try values.decode(Int.self, forKey: .id))
        self.content = (try values.decode(Content.self, forKey: .content))
    }
}


class Content: Decodable {
    let markdown: String?
    let html: String?
    
    enum CodingKeys: String, CodingKey {
        case markdown, html
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.markdown = (try? values.decode(String.self, forKey: .markdown))
        self.html = (try? values.decode(String.self, forKey: .html))
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








// ----------- AUTHOR ------------------------


//required init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//    self.id = (try? values.decode(Int.self, forKey: .id))
//    self.login = (try? values.decode(String.self, forKey: .login))
//    self.url = (try? values.decode(String.self, forKey: .url))
//}





/*



class TopicModel: Decodable {
    let id: Int?
    let name: String?
    let author: Author?
    let kind: String?
    let createdAt, updatedAt: Date?
    let pinnedAt, lockedAt, pinner, locker: String?
    let messagesURL: String?
    let message: Message?
    let tags: [Tag]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, author, kind
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pinnedAt = "pinned_at"
        case lockedAt = "locked_at"
        case pinner, locker
        case messagesURL = "messages_url"
        case message, tags
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.name = (try? values.decode(String.self, forKey: .name))
        self.author = (try? values.decode(Author.self, forKey: .author))
        self.kind = (try? values.decode(String.self, forKey: .kind))
        
        l
        
        self.pinnedAt = (try? values.decode(String.self, forKey: .pinnedAt))
        self.lockedAt = (try? values.decode(String.self, forKey: .lockedAt))
        self.pinner = (try? values.decode(String.self, forKey: .pinner))
        self.locker = (try? values.decode(String.self, forKey: .locker))
        self.messagesURL = (try? values.decode(String.self, forKey: .messagesURL))
        self.message = (try? values.decode(Message.self, forKey: .message))
        self.tags = (try? values.decode([Tag].self, forKey: .tags))
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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.login = (try? values.decode(String.self, forKey: .login))
        self.url = (try? values.decode(String.self, forKey: .url))
    }
}

class Message: Decodable {
    let id: Int?
    let content: Content?
    
    enum CodingKeys: String, CodingKey {
        case id, content
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.content = (try? values.decode(Content.self, forKey: .content))
    }
}

class Content: Decodable {
    let markdown: String?
    let html: String?
    
    enum CodingKeys: String, CodingKey {
        case markdown, html
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.markdown = (try? values.decode(String.self, forKey: .markdown))
        self.html = (try? values.decode(String.self, forKey: .html))
    }
}

class Tag: Decodable {
    let id: Int?
    let name, kind: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, kind
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.name = (try? values.decode(String.self, forKey: .name))
        self.kind = (try? values.decode(String.self, forKey: .kind))
    }
}


*/
