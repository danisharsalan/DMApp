//
//  CalendarViewController.swift
//  Dance Marathon
//
//  Created by Danish Arsalan on 1/25/16.
//  Copyright © 2016 Danish Arsalan. All rights reserved.
//

import UIKit

class CalendarViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    private var collapseDetailViewController = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        
        splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 12
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        // Configure the cell...
        
        return cell
    }
    
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool{
        return true
    }
    
}