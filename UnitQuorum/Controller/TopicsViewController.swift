//
//  TopicsViewController.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/1/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//


//  GET /v2/messages/graph(/on/:field(/by/:interval))
//  GET /v2/topics/:topic_id/messages/:message_id/messages
// GET /v2/topics/:topic_id/messages    }

//"v2/topics/\(id)/messages?page[number]=\(pageNumber)&page[size]=\(pageSize)"

import Foundation
import UIKit

class TopicsViewController : UITableViewController
{
    var topics : [TopicJSON] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Client.sharedInstance.myLogin == "" ||  Client.sharedInstance.myId == 0 || Client.sharedInstance.token == ""){
            Client.sharedInstance.token = ""
            Client.sharedInstance.isSignedIn = false
            Client.sharedInstance.myId = 0
            Client.sharedInstance.myLogin = ""
            let alert = UIAlertController(title: "Error", message: "Could't obtain user's data/token", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                self.navigationController?.viewControllers.forEach { ($0 as? LoginViewController)?.viewDidLoad()}
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            } else {
                self.getTopics()
                print("hello from topics list Intra")
            }
    }
    
    func getTopics() {
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
                //print(data)
            do {
                
              //  let json :  [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary])!
               // print(json)
                
                    self.parseTopic(d : data)
                
            }
            catch {
               // print(error)
                //print("error in get_topics")
            }
//                DispatchQueue.main.async {
//                    self.parseTopic(d : data)
//
//                }
            }
        session.resume()
    }
    
    @IBAction func CreateButtontapped(_ sender: UIBarButtonItem) {
        print("create button tapped")
        let vc = openCreateTopicViewController() as!  CreateNewTopicViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
//            print("Topic ID : \(topic.id)")
//            print("Created at: \(topic.created_at)")
//            print("Updated at: \(topic.updated_at)")
//            print("Topic name: \(topic.name)")
//            print("Author name: \(topic.author.login)")
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
        //vc.topic = self.topics[indexPath.row]
        vc.topicID = self.topics[indexPath.row].id

        self.navigationController?.pushViewController(vc, animated: true)
    }
//
    
    
    func getViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "FullTopicStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "FullTopicDisplayViewController") as! FullTopicDisplayViewController
         //vc.topic = topics[indexPath]
        
        //print("DisaplyTopic VC created")
        return vc
    }
    
    func openCreateTopicViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "CreateNewTopic", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "CreateNewTopicViewController") as! CreateNewTopicViewController
        return vc
    }
    
  
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicCell
        let topic = topics[indexPath.row]
        cell.authorLbl.text = topic.author.login
        cell.dateLbl.text = topic.created_at.toDate()?.toString()
        cell.topicLbl.text = topic.name
        //cell.textLabel?.text = "\(topic.author.login): \(topic.name) created on \(topic.created_at)\n"
        ///cell.textLabel?.sizeToFit()
        //cell.textLabel?.numberOfLines = 0
        cell.designSelf()
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func MyTopicsButtonTapped(_ sender: UIBarButtonItem) {
        
        print("Opened my Topics")
        let vc = openMyTopicsViewController() as! MyTopicsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    
        
    }
    
    func openMyTopicsViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "MyTopics", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "MyTopicsViewController") as! MyTopicsViewController
        return vc
    }
    
    @IBAction func LogOutButtonTapped(_ sender: UIBarButtonItem) {
        print("Log Out Button Tapped")
        Client.sharedInstance.token = ""
        Client.sharedInstance.isSignedIn = false
        Client.sharedInstance.myId = 0
        Client.sharedInstance.myLogin = ""
        navigationController?.viewControllers.forEach { ($0 as? LoginViewController)?.viewDidLoad()}
        navigationController?.popViewController(animated: true)
    }
    
}


extension TopicsViewController {
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
