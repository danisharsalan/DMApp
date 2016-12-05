//
//  DMWebpage.swift
//  Dance_Marathon
//
//  Created by Danish Arsalan on 12/13/15.
//  Copyright © 2015 Danish Arsalan. All rights reserved.
//

import UIKit

class DMWebpage: UIViewController {
    
    @IBOutlet var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let URL = Foundation.URL(string: "http://219dm.weebly.com/")
        let requestObj = URLRequest(url: URL!);
        WebView.loadRequest(requestObj);
    }
    
    func goBack(_ sender:UIBarButtonItem){
        WebView.goBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
