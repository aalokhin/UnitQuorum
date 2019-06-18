//
//  TopicToSend.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/17/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation




class TopicToSend : Encodable {
    
    //required values
    
    let name : String
    let kind : String
    let language_id : String
    let messages_attributes : [MessagesAttributes]
    
//    let content : String
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case kind = "kind"
        case messages_attributes = "messages_attributes"
        
        
//        case content = "content"
    }
    
    init(name : String, content : String, kind : String, author : Int)
    {
        self.name = name
        self.kind = kind
        self.language_id = "3"
        self.messages_attributes = [MessagesAttributes(content : content, author_id : author)]
        
//        self.content = contenš
        
    }
}


class MessagesAttributes : Encodable {
    let content: String
    let author_id: Int
    
    enum CodingKeys: String, CodingKey {
        case content = "content"
        case author_id = "author_id"
    }
    
    init(content: String, author_id : Int) {
        self.content = content
        self.author_id = author_id
    }
}




//POST /v2/topics.json
//    {
//        "topic": {
//            "author_id": "94",
//            "cursus_ids": [
//            "1"
//            ],
//            "kind": "normal",
//            "language_id": "3",
//            "messages_attributes": [
//            {
//            "author_id": "21",
//            "content": "Hello world",
//            "messageable_id": "1",
//            "messageable_type": "Topic"
//            }
//            ],
//            "name": "The daily unicorn #837 🦄",
//            "tag_ids": [
//            "9",
//            "7",
//            "8"
//            ],
//            "survey_attributes": {
//                "name": "Who belongs with Geralt ?",
//                "survey_answers_attributes": [
//                {
//                "name": "Yennefer"
//                },
//                {
//                "name": "Triss"
//                },
//                {
//                "name": "Roach"
//                }
//                ]
//            }
//        }
//}
