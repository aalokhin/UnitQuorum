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
    
    @IBOutlet weak var topicText: UITextView!
    
    @IBOutlet weak var topicName: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Hello from Create Topic View!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    }
    
    @IBAction func SaveTapped(_ sender: UIBarButtonItem) {
        
        if (topicText.text != nil && topicName.text != "")
        {
            let topic = TopicToSend(name : topicName.text!, content : topicText.text!)
            print(topic.name)
            print(topic.content)
            print("saved")
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let alertController = UIAlertController(title: "hey there", message: "Please enter the name and the text of the topic", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "We'll do", style: .default, handler: nil)
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        

    }
    
    @IBAction func CancelTapped(_ sender: UIBarButtonItem) {
        print("cancel tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


