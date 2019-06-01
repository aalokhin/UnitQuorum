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
    var code = ""
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (Client.sharedInstance.isSignedIn == false)
        {
            print("helolo newbie")
            
           
        }
       else
        {
            webLoginButton.isHidden = true
            passwordTextField.isHidden = true
            plainLoginButton.isHidden = true
            xloginTextField.isHidden = true
            print("helolo you are here already ")
            
        }
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
        
        
        let authURL = Client.authorizationURL
        let callbackUrlScheme = Client.callbackUrlScheme
        
        self.authSession = SFAuthenticationSession.init(url: authURL!, callbackURLScheme: callbackUrlScheme, completionHandler:{ (callBack:URL?, error:Error?) in
            // handle auth response
            guard error == nil, let successURL = callBack else {
                print("Some error in login")
                return
            }
            Client.sharedInstance.isSignedIn = true


            
            var oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first
            
            // Do what you now that you've got the token, or use the callBack URL
            print("here is your token : -----------------")
            print(oauthToken ?? "No OAuth Token")
            
            guard let code = oauthToken?.value else {
                print("No code received")
                return;
            }

            
            self.code = code
            print ("here is your code : \(self.code)")
            self.getToken()
            
           
        })
        //Kick it off
        self.authSession?.start()
    }
    
    func getToken(){
        
        let url = URL(string: "https://api.intra.42.fr/oauth/token?client_id=\(Client.apiUid)&client_secret=\(Client.apiSecret)&\(self.code)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
       
        DispatchQueue.global().async{
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                if let err = error {
                    print("error occured \(err)")
                }else if let d = data
                {
                    self.parseToken(d : d)
                    Client.sharedInstance.isSignedIn = true
                    let vc = self.getTopicsViewController()

                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            task.resume()
        }
    }
    
    func parseToken(d : Data!)
    {
        let decoder = JSONDecoder()
        // let tweets = [DecodableTweet]
          let t = try! decoder.decode(TokenJSON.self, from: d)
        print("Access: \(t.access_token)")
        print("Created at: \(t.created_at)")
        print("Expires in: \(t.expires_in)")
        print("Token type: \(t.token_type)")
        print("Before: \(Client.sharedInstance.token)")
        Client.sharedInstance.setToken(t : t.access_token)
       // Client.sharedInstance.isSignedIn = true
        print("After: \(Client.sharedInstance.token)")

    }
    
    
    func getTopicsViewController() -> UITableViewController {
        let storyboard = UIStoryboard.init(name: "Topics", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "TopicsViewController") as! TopicsViewController
        print("vc created")
    
        return vc
    }
        
    
    
    
    func getViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "WebViewDisplay", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "WebViewController") as! WebViewController
        print("vc created")
        return vc
    }
    
}
