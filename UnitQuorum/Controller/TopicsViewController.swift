//
//  TopicsViewController.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/1/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class TopicsViewController : UITableViewController
{
    var topics : [TopicJSON] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.spinnerFooter.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100)
//        self.spinnerFooter.startAnimating()
        self.getTopics()
        print("hello from table twitter")
    }
    
    func getTopics(){
        let urlPath: String = "https://api.intra.42.fr/v2/topics"
        let url = URL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let response = response {
                print("response received")
                //print(response)
            }
             guard let data = data else {
                  //  print("no data received")
                    return
                }
                print(data)
            do {
                
                let json :  [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary])!
//
                print(json)
               // let i = 0
//                for one in data
//                {
                    self.parseTopic(d : data)
                
//                }
            }
            catch {
                print(error)
                print("error in get_topics")
            }
//                DispatchQueue.main.async {
//                    self.parseTopic(d : data)
//
//                }
            }
        session.resume()
    }
    
    
    func parseTopic(d : Data!)
    {
        let decoder = JSONDecoder()
        // let tweets = [DecodableTweet]
        
        //let topics = [TopicJSON]
        
        let t = try! decoder.decode([TopicJSON].self, from: d)
        for topic in t
        {
            topics.append(topic)
            print("Topic ID : \(topic.id)")
            print("Created at: \(topic.created_at)")
            print("Updated at: \(topic.updated_at)")
            print("Topic name: \(topic.name)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
//        if !self.topics.isEmpty {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        } else {
//            DispatchQueue.main.async {
//                self.spinnerFooter.stopAnimating()
//                self.tableView.tableFooterView = UIView()
//            }
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(topics.count)
        return topics.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
        let topic = topics[indexPath.row]
        cell.textLabel?.text = "\(topic.name)\n"
        cell.textLabel?.sizeToFit()
//
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
