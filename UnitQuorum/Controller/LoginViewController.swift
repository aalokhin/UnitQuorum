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
     

            print("Is signed is \(Client.sharedInstance.isSignedIn)")
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
           // print("here is your token : -----------------")
           // print(oauthToken ?? "No OAuth Token")
            
            guard let code = oauthToken?.value else {
                print("No code received")
                return;
            }

            
            self.code = code
            //print ("here is your code : \(self.code)")
            self.getToken()
            
            
           
        })
        //Kick it off
        self.authSession?.start()
    }
    
   
    
    func getToken(){

        let queryItems = [
            NSURLQueryItem(name: "grant_type", value: "authorization_code"),
            NSURLQueryItem(name: "client_id", value: Client.apiUid),
            NSURLQueryItem(name: "client_secret", value : Client.apiSecret),
            NSURLQueryItem(name: "code", value: code),
            NSURLQueryItem(name: "redirect_uri", value: Client.redirectURI),
            NSURLQueryItem(name: "scope", value: "forum")
            ]
        let urlComps = NSURLComponents(string: "https://api.intra.42.fr/oauth/token")!
        urlComps.queryItems = queryItems as [URLQueryItem]
        let url = urlComps.url!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       
        DispatchQueue.global().async{
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                if let err = error {
                    print("error occured \(err)")
                }else if let d = data
                {
                    self.parseToken(d : d)
//  *****************************>>>>>>>>>>>>>>> I don't kmow how to synchronize threads!!!!!!!!!!!!!!!!!
                    
                    
                    
//                    if (Client.sharedInstance.myLogin == "" ||  Client.sharedInstance.myId == 0 || Client.sharedInstance.token == ""){
//                        self.callErrorWithCustomMessage(message: "Could't obtain user's data/token")
//
//                        return
//                    }
                    
                    Client.sharedInstance.isSignedIn = true
                 
                    let vc = self.getTopicsViewController()
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            task.resume()
        }
    }
    
    func parseToken(d : Data!){
        let decoder = JSONDecoder()
        guard let t = try? decoder.decode(TokenJSON.self, from: d) else {
            print("error decoding token")
            callErrorWithCustomMessage(message : "Errror decoding token!")
            return
        }
        Client.sharedInstance.setToken(t : t.access_token)
        Client.sharedInstance.isSignedIn = true
        getMe()
       

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


extension LoginViewController{
    
    func getMe()
    {
        
        print("************** GET meeeee *******")
        
        let urlPath: String = "https://api.intra.42.fr/v2/me"
        let url = URL(string : urlPath)
        var request = URLRequest(url : url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if response == nil{
                self.callErrorWithCustomMessage(message: "No response in Login Controller received :c")
                return
            }
            
            guard let data = data else {
                print("no data received")
                self.callErrorWithCustomMessage(message: "No data received :c")
                return
            }
            
            print(data)
            do {
                // print("*******************************************  DEBUG  *********************************************************")
                //data = "any string".data(using: .utf8)!
                // print("*******************************************  DEBUG  *********************************************************")
                
                guard let dic : NSDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else
                {
                    print("no data received")
                    self.callErrorWithCustomMessage(message: "Error deserializing your topic. Somthing went wrong")
                    return ;
                }
                guard let login = dic.value(forKey: "login"), let myId = dic.value(forKey: "id")
                    else {
                        print("Couldn't get user's data")
                        self.callErrorWithCustomMessage(message: "Couldn't get login")
                        return
                }
                Client.sharedInstance.myLogin = login as! String
                Client.sharedInstance.myId = myId as! Int
            }
            catch (let err) {
                print("Error i getting user's info")
                self.callError(error: err as NSError)
            }
            
        }
        session.resume()
    }
    
    
    
    func callErrorWithCustomMessage(message : String) {
        
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertControllerStyle.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func callError(error: NSError) {
        
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: UIAlertControllerStyle.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}




//        let url = URL(string: "https://api.intra.42.fr/oauth/token?client_id=\(Client.apiUid)&client_secret=\(Client.apiSecret)&\(self.code)")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
////        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
//        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)



