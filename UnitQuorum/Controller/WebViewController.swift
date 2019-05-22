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

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var link : String! = nil
    var myWebView: WKWebView!


    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        print("hi")
        myWebView = WKWebView()
        myWebView.navigationDelegate = self
        view = myWebView
        let url = URL(string: link)!
        myWebView.load(URLRequest(url: url))
        myWebView.allowsBackForwardNavigationGestures = true
    }

}
