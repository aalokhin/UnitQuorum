//
//  WebViewController.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 5/22/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit
import WebKit



class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate  {

   var link : String! = nil
    @IBOutlet weak var wkView: WKWebView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        print("hi")
        print("Singleton works: \(Client.sharedInstance.token)")

        startAuthorization()
    }
    
    func startAuthorization()
    {
       let authorizationURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=a3e38e966c9817266d40eabd4dcdf82bdca4bed880f7da7c490a17f8658f41fd&redirect_uri=myapp00%3A%2F%2Fforum&response_type=code")

        
        var accessRequest = URLRequest(url : authorizationURL!)
        accessRequest.httpMethod = "GET"
        
        wkView.uiDelegate = self
        wkView.navigationDelegate = self
        wkView.load(accessRequest)

    }
    
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        
        print("hey")
        guard let components = URLComponents.init(string: webView.url!.absoluteString),
            let code = components.queryItems?.first(where: {$0.name == "code"})?.value,
            let state = components.queryItems?.first(where: {$0.name == "state"})?.value else { return }
        DispatchQueue.main.async {
           // self.delegate?.isSignIn()
            print(code)
            print(state)
        }

    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("hey from policy ")
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url!
        
        print("hey from webview)")
        print(url)

        
        return true
    }
    
    
}

//
//
//extension WebViewController : {
//
//
//
//
//
//}
//
//
////        GetTokenRequest().request(contactId: Client.apiUid, secretKey: Client.apiSecret, code: code, state: state) { (model, error) in
//            print("Token created at \(model?.createdAt?.toString(format: Constants.fullDateFormat) ?? ""), expires in \(model?.expiresIn ?? 0) seconds")
//            if let token = model?.token {
//                DataSingleton.shared.token = token
//                DispatchQueue.main.async {
//                    self.delegate?.isSignIn()
//                }
//            }
//        }
//        
//        
//    }
//    
//
// }

//
//static func getToken(clientId: String, clientSecret: String, code: String, state: String) -> String {
//    return "oauth/token?grant_type=authorization_code&client_id=\(clientId)&client_secret=\(clientSecret)&code=\(code)&redirect_uri=\(Constants.redirectURI)&state=\(state)"
//}
//
//static func authorize(clientId: String) -> String {
//    return "oauth/authorize?client_id=\(clientId)&redirect_uri=\(Constants.redirectURI)&scope=\(Constants.scope)&state=\(Constants.state)&response_type=code"
//}
