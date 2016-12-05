//
//  ViewController.swift
//  Dance_Marathon
//
//  Created by Danish Arsalan, Brendan DeLeon, and Harrison Moy on 12/7/15.
//  Copyright © 2015 Danish Arsalan. All rights reserved.
//

import UIKit
import Fuzi

class ViewController: UIViewController, UITextFieldDelegate, UISplitViewControllerDelegate {
    @IBOutlet weak var logoImage: UIButton!
    
    @IBOutlet weak var image420: UIImageView!
    var imageList420 = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.idField.delegate = self
        let link = "White.png"
        logoImage.setImage(UIImage(named: link), for: UIControlState())
        
        var linkToLogoImage = "http://219dm.weebly.com/uploads/5/0/1/4/5014593/1444316288.png"
        
        let myURLString = "http://219dm.weebly.com"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL)
            //print("HTML : \(myHTMLString)")
            let doc = try HTMLDocument(string: myHTMLString, encoding: String.Encoding.utf8)
            
            for script in doc.xpath("/html/body/div[1]/div[1]/div[1]/div/span/a/img") {
                //NSLog(script["src"]!)
                linkToLogoImage = "http://219dm.weebly.com" + script["src"]!
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        
        if let url  = URL(string: linkToLogoImage),
            let data = try? Data(contentsOf: url)
        {
            logoImage.setImage(UIImage(data: data), for: UIControlState())
        }
        image420.image = UIImage(named:"White")!
        let stringKey = UserDefaults.standard
        //finalResult.text = stringKey.stringForKey("finalResult")
        idField.text = stringKey.string(forKey: "IDInput")
        //self.idField.text = defaultsKeys.savedID
        //self.finalResult.text = defaultsKeys.savedIDDonCount
    }
    
//    enum defaultsKeys {
//        static let savedID = "Saved ID"
//        static let savedIDDonCount = "Saved ID Info String"
//    }
//    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var idNumLab: UILabel!
    
    
    @IBOutlet weak var idField: UITextField!
    func textFieldShouldReturn(_ idField: UITextField) -> Bool {
        idField.resignFirstResponder()
        return true;
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func showCalendar(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let spv = storyboard.instantiateViewController(withIdentifier: "splitView") as! UISplitViewController
        self.view.window?.rootViewController = spv
        spv.delegate = self
    }
    
    
    @IBOutlet weak var finalResult: UILabel!
    
    
    @IBAction func sub(_ sender: AnyObject) {
        DispatchQueue.main.async(execute: {
            //perform all UI stuff here
            self.finalResult.text = "Searching..."
        })
        
        if let value = idField.text{
            UserDefaults.standard.set(value, forKey: "IDInput")
            UserDefaults.standard.synchronize()
            //self.defaults.setValue(self.idField.text, forKey: defaultsKeys.savedID)
            if (idField.text == "666"){
                DispatchQueue.main.async(execute: {
                    //perform all UI stuff here
                    self.finalResult.text = "No such ID was found."
            //      NSUserDefaults.standardUserDefaults().setObject(self.finalResult.text, forKey: "finalResult")
        //          NSUserDefaults.standardUserDefaults().synchronize()
                    for i in 1...10{
                        let imageName = "\(i).png"
                        self.imageList420.append(UIImage(named: imageName)!)
                    }
                    self.image420.animationImages = self.imageList420
                    self.image420.startAnimating()
                })
                
            } else if (idField.text == "1738"){
                DispatchQueue.main.async(execute: {
                    //perform all UI stuff here
                    self.finalResult.text = "No such ID was found."
//                  NSUserDefaults.standardUserDefaults().setObject(self.finalResult.text, forKey: "finalResult")
//                  NSUserDefaults.standardUserDefaults().synchronize()
                    self.image420.image = UIImage(named:"1738.jpg")!
                    
                })
            } else if (idField.text == "58979" || idField.text!.lowercased() == "danish"){
                DispatchQueue.main.async(execute: {
                    //perform all UI stuff here
                    self.finalResult.text = "Danish has collected $00.00."
//                  NSUserDefaults.standardUserDefaults().setObject(self.finalResult.text, forKey: "finalResult")
//                  NSUserDefaults.standardUserDefaults().synchronize()
                    self.image420.image = UIImage(named:"Danish.jpg")!
                    
                })
            } else if (idField.text == "61038" || idField.text!.lowercased() == "harrison"){
                DispatchQueue.main.async(execute: {
                    //perform all UI stuff here
                    self.finalResult.text = "Harrison has collected $00.00"
//                  NSUserDefaults.standardUserDefaults().setObject(self.finalResult.text, forKey: "finalResult")
//                  NSUserDefaults.standardUserDefaults().synchronize()
                    self.image420.image = UIImage(named:"harrison ford.jpg")!
                    
                })
            } else if (idField.text == "59390" || idField.text!.lowercased() == "brandon"){
                DispatchQueue.main.async(execute: {
                    //perform all UI stuff here
                    self.finalResult.text = "Brandon has collected $00.00."
                    self.image420.image = UIImage(named:"1738.jpg")!
                    
                })
            } else if(idField.text!.characters.count > 5 || idField.text!.characters.count < 5){
                DispatchQueue.main.async(execute: {
                    //perform all UI stuff here
                    self.finalResult.text = "No such ID was found."
//                  NSUserDefaults.standardUserDefaults().setObject(self.finalResult.text, forKey: "finalResult")
//                  NSUserDefaults.standardUserDefaults().synchronize()
                    self.image420.stopAnimating()
                    self.viewDidLoad()
                })
            } else {
                if let URL = URL(string: "http://www.fahrenbacher.com/dm/retrieve.php?id=" + value) {
                    let sessionConfig = URLSessionConfiguration.default
                    let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
                    let request = NSMutableURLRequest(url: URL)
                    request.httpMethod = "GET"
                    let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: NSError?) -> Void in
                        if (error == nil) {
                            // Success
                            let content = NSString(data: data!, encoding: String.Encoding.ascii)
                            let y = Double(round(1000*(content?.doubleValue)!)/1000)
                            //let statusCode = (response as! NSHTTPURLResponse).statusCode
                            //print("Success: \(content!)")
                            if(y == 0 || content == nil){
                                DispatchQueue.main.async(execute: {
                                    //perform all UI stuff here
                                    self.finalResult.text = value + " has collected $00.00"
//                                  NSUserDefaults.standardUserDefaults().setObject(self.finalResult.text, forKey: "finalResult")
//                                  NSUserDefaults.standardUserDefaults().synchronize()
                                    self.image420.stopAnimating()
                                    self.viewDidLoad()
                                })
                            } else {
                                DispatchQueue.main.async(execute: {
                                    //perform all UI stuff here
                                    self.finalResult.text = value + " has collected $" + String(y) + "!"
//                                  NSUserDefaults.standardUserDefaults().setObject(self.finalResult.text, forKey: "finalResult")
//                                  NSUserDefaults.standardUserDefaults().synchronize()
                                    self.image420.stopAnimating()
                                    self.viewDidLoad()
                                })
                            }
                            // This is your file-variable:
                            // data
                        }
                        else {
                            // Failure
                            print("Failure: %@", error?.localizedDescription);
                        }
                    })
                    task.resume()
                }
            }
            //self.defaults.synchronize()
        }
    }
}

