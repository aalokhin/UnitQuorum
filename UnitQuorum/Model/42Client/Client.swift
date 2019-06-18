//
//  Client.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 5/22/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

//Singleton instance

final class Client {
    
    static let apiUid = "a3e38e966c9817266d40eabd4dcdf82bdca4bed880f7da7c490a17f8658f41fd"
    static let apiSecret = "56fecc48f9aeeb77e9cfefad10d4ea3f0c08c005909a1327630984c8dbcc1d7b"
    
    static let baseUrl = "https://api.intra.42.fr/"
    
    static let redirectURI = "myapp00://forum".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    
    static let scope = "public forum"
    static let callbackUrlScheme =  "myapp00://forum"
    
    
    static let authorizationURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=a3e38e966c9817266d40eabd4dcdf82bdca4bed880f7da7c490a17f8658f41fd&redirect_uri=myapp00%3A%2F%2Fforum&response_type=code")
    
//    static let USERDEFAULTS_KEY_TOKEN = "user_token"
//    static let USERDEFAULTS_KEY_ME = "me_key"
//
    var token : String
    
    static let DateFormat = "dd.MM.yyyy HH:mm:ss"
    var isSignedIn : Bool
    
    
    //============================================================SINGLETON============================================================
    static let sharedInstance = Client()
    
    private init(){
        print("Singleton client has been initialized")
        token = ""
        isSignedIn = false
    }
    //============================================================SINGLETON============================================================

    
    func setToken(t : String)
    {
        self.token = t
    }
}

