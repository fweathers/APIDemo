//
//  ViewController.swift
//  APIDemo
//
//  Created by Felicia Weathers on 10/28/16.
//  Copyright © 2016 Felicia Weathers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + locationTextField.text! + ",uk&appid=481d88783d376954dbbebf3d1bedbe8a") {
        
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
                            
                            //                            print(description)
                            DispatchQueue.main.sync(execute: { // dispatch to avoid delay in displaying text
                                
                                self.descriptionLabel.text = description
                                
                            })
                            
                        }
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                }
            }
        }
        task.resume()
            
        } else {
            
            descriptionLabel.text = "Couldn't find weather for that location. Please try another."
            
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
           }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

