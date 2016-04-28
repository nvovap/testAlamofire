//
//  AddViewController.swift
//  TodoApp
//
//  Created by nvovap on 4/28/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    
    
    @IBAction func save(sender: AnyObject) {
        Alamofire.request(.POST, "https://alamofire.herokuapp.com/todo", parameters: ["name" : name.text!, "age" : age.text!])
        
        self.navigationController?.popViewControllerAnimated(true)
        
        //Alamofire.request(<#T##method: Method##Method#>, <#T##URLString: URLStringConvertible##URLStringConvertible#>, parameters: <#T##[String : AnyObject]?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##[String : String]?#>)
    }
}
