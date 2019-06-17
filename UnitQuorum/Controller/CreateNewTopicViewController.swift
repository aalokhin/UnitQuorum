//
//  CreateNewTopicViewController.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/17/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class CreateNewTopicViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var topicText: UITextView!
    
    @IBOutlet weak var topicName: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Hello from Create Topic View!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    }
    
    @IBAction func SaveTapped(_ sender: UIBarButtonItem) {
        
        if (topicText.text != nil && topicName.text != "")
        {
            let topic = TopicToSend(name : topicName.text!, content : topicText.text!, kind : "normal", author : 4)
           
            
            let jsonEncoder = JSONEncoder()
            do
            {
                let jsonData = try jsonEncoder.encode(topic)
                print(jsonData)
               
                do
                {
                    let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
                    print("************************** \(json) ************************")
                    
                }
                catch{
                    print("error")
                }
                
                
                
            }
            catch{
                print("Error encoding")
            }
            

            
//            print(topic.name)
//            print(topic.messages_attributes)
//            print(topic.messages_attributes[0].content)
//            print(topic.messages_attributes[0].author_id)
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
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("in here FIrst responder works")
//        self.topicText.becomeFirstResponder()
//        return true
//    }
    
   
    
    @IBAction func CancelButtonTapped(_ sender: UIBarButtonItem) {
        print("cancel2 tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
}



