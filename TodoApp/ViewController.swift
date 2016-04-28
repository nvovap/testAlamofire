//
//  ViewController.swift
//  TodoApp
//
//  Created by nvovap on 4/27/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    var jsonArray: NSMutableArray?
    var newArray: Array<[String:String]> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        downloadAndUpdate()
        
    }
    
    
    func downloadAndUpdate() {
        Alamofire.request(.GET, "https://alamofire.herokuapp.com/todo").responseJSON { (response: Response) in
            //            print(response.request)
            //            print(response.response)
            //            print(response.data)
            //            print(response.result)
            
            if let JSON = response.result.value {
                
                self.jsonArray = JSON as? NSMutableArray
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                
                
            }
        }
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            print(jsonArray![indexPath.row])
            
            if let id = jsonArray![indexPath.row]["_id"] as? String {
                print("ID is "+id)
                
                Alamofire.request(.DELETE, "https://alamofire.herokuapp.com/todo/"+id).responseString(completionHandler: { (response) in
                    self.downloadAndUpdate()
                })
                                   
            }
        } else if editingStyle == .Insert {
            
        }
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if let jsonArray = jsonArray {
            count = jsonArray.count
        }
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
        if let jsonArray = jsonArray {
            if let name = jsonArray[indexPath.row]["name"] as? String {
                cell.textLabel?.text = name
            } else {
                cell.textLabel?.text = ""
            }
            
            if let age = jsonArray[indexPath.row]["age"] as? String {
                cell.detailTextLabel?.text = age
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
        
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    

}

