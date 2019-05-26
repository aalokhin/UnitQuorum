//
//  LoginViewController.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 5/22/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

// let authorizationURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=a3e38e966c9817266d40eabd4dcdf82bdca4bed880f7da7c490a17f8658f41fd&redirect_uri=myapp00%3A%2F%2Fforum&response_type=code")

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var xloginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var plainLoginButton: UIButton!
    @IBOutlet weak var webLoginButton: UIButton!
    
    var authSession: SFAuthenticationSession?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    @IBAction func webLoginButtonTapped(_ sender: UIButton) {
        let vc = getViewController() as! WebViewController
        vc.link = "https://profile.intra.42.fr"
        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    
    
    @IBAction func plainLoginButtonTapped(_ sender: Any) {
        
//        let authURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(Client.apiUid)")
        
        let authURL = Client.authorizationURL
        
        let callbackUrlScheme = "myapp00://forum"
        
        self.authSession = SFAuthenticationSession.init(url: authURL!, callbackURLScheme: callbackUrlScheme, completionHandler:{ (callBack:URL?, error:Error?) in

            // handle auth response
            guard error == nil, let successURL = callBack else {
                return
            }
            
            let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first
            
            // Do what you now that you've got the token, or use the callBack URL
            
            print ("here is your token : -----------------")
            print(oauthToken ?? "No OAuth Token")
            
            
           
        })
        //Kick it off
        self.authSession?.start()
    }
    
    
    
    func getViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "WebViewDisplay", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "WebViewController") as! WebViewController
        print("vc created")
        return vc
    }
    
}
