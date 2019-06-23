//
//  MyTopicsViewController.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/23/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class MyTopicsViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        print("Hi from this view controller!")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}


extension MyTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return  5
    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("cellForRowAt1")
//       let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
//        //cell.textLabel?.sizeToFit()
//        print("cellForRowAt2")
//        cell.textLabel?.text = "lalala"
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           print("cellForRowAt1")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       // let topic = topics[indexPath.row]
        cell.textLabel?.text = "lalala"

        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
    
    
}


//extension MyTopicsViewController: UITableViewDelegate, UITableViewDataSource {
//    
//}

