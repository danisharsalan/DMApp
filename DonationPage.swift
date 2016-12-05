//
//  DonationPage.swift
//  Dance_Marathon
//
//  Created by Danish Arsalan on 12/13/15.
//  Copyright © 2015 Danish Arsalan. All rights reserved.
//

import UIKit
//import Fuzi

class DonationPage: UIViewController {
    
    @IBOutlet var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let myURLString = "http://219dm.weebly.com/charity-of-the-year.html"
        guard let myURL = Foundation.URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        var linkToDonationPage = "https://www.google.com"
        
        do {
            let myHTMLString = try String(contentsOf: myURL)
            //print("HTML : \(myHTMLString)")
            let doc = try HTMLDocument(string: myHTMLString, encoding: String.Encoding.utf8)
            
            if let firstAnchor = doc.firstChild(xpath: "//*[@id=\"wsite-content\"]/div[6]/a") {
                //NSLog(firstAnchor["href"]!)
                linkToDonationPage = firstAnchor["href"]!
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        
        let URL = Foundation.URL(string: linkToDonationPage)
        let requestObj = URLRequest(url: URL!);
        WebView.loadRequest(requestObj);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
