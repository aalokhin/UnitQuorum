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
                
              //  let json :  [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary])!
               // print(json)

                    self.parseTopic(d : data)
                
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
            print("Author name: \(topic.author.login)")
            //print("Topic message markdown :  \(topic.message.content.markdown)")
            // print("Topic message html:  \(topic.message.content.html)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(topics.count)
        return topics.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")

       // let vc = FullTopicDisplayViewController.create(topic: self.topics[indexPath.row])
       // self.navigationController?.pushViewController(vc, animated: true)


        let vc = getViewController() as!  FullTopicDisplayViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
//
    
    
    func getViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "FullTopicStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "FullTopicDisplayViewController") as! FullTopicDisplayViewController
        //print("DisaplyTopic VC created")
        return vc
    }
    
  
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
        let topic = topics[indexPath.row]
        cell.textLabel?.text = "\(topic.author.login): \(topic.name) created on \(topic.created_at)\n"
        cell.textLabel?.sizeToFit()
//
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
