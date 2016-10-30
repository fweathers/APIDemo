//
//  ViewController.swift
//  APIDemo
//
//  Created by Felicia Weathers on 10/28/16.
//  Copyright © 2016 Felicia Weathers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=481d88783d376954dbbebf3d1bedbe8a")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        print(jsonResult["name"])
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String { // gets info from weather -> is an array with one item -> a dictionary -> print description
                            
                            print(description)
                            
                        }
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                }
            }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

