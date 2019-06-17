//
//  CreateNewTopicViewController.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/17/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class CreateNewTopicViewController : UIViewController {
    
     override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Hello from Create Topic View!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    }
    
    @IBAction func SaveTapped(_ sender: UIBarButtonItem) {
        print("save tapped")

    }
    
    @IBAction func CancelTapped(_ sender: UIBarButtonItem) {
        print("cancel tapped")
        self.navigationController?.popViewController(animated: true)
    }
}
