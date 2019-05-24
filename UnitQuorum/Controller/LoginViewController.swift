//
//  LoginViewController.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 5/22/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var xloginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var plainLoginButton: UIButton!
    @IBOutlet weak var webLoginButton: UIButton!
    
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
    
    func getViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "WebViewDisplay", bundle: nil)
       
        let vc = storyboard.instantiateViewController(withIdentifier : "WebViewController") as! WebViewController
       // vc.delegate = self
        
        print("vc created")
        return vc
        
//        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
//
//        return vc
 
    }
    
}
