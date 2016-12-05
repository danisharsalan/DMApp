//
//  EventTableViewCell.swift
//  Dance Marathon
//
//  Created by Danish Arsalan on 3/24/16.
//  Copyright © 2016 Danish Arsalan. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var addToCalendarButtonTapped : (() -> Void)? = nil
    
    @IBAction func addToCalendar(_ sender: AnyObject) {
        
        if let addToCalendarButtonTapped = self.addToCalendarButtonTapped {
            addToCalendarButtonTapped()
        }
        
    }
}
