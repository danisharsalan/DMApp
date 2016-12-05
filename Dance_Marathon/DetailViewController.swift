//
//  DetailViewController.swift
//  Dance Marathon
//
//  Created by Danish Arsalan on 1/29/16.
//  Copyright © 2016 Danish Arsalan. All rights reserved.
//

import UIKit
import Fuzi
import EventKit

class DetailViewController: UITableViewController {
    
    class CurrentYear {
        let calendar = Calendar.current
        var year: Int {
            return  (calendar as NSCalendar).component(.year, from: Date())
        }
    }
    
    class CurrentMonth {
        let calendar = Calendar.current
        var month: Int {
            return  (calendar as NSCalendar).component(.month, from: Date())
        }
    }
    
    let currentYear =  CurrentYear().year
    let currentMonth = CurrentMonth().month
    var eventName = [String]()
    var eventDate = [String]()
    var eventTime = [String]()
    
    //@IBOutlet weak var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var year = currentYear
        
        // Do any additional setup after loading the view.
        if (currentMonth <= 12 && currentMonth >= 7) {
            
        }
        
        let master = CalendarSingleton.getSingleton()
        
        _ = master.getMonthsListString()
        var monthListInt = master.getMonthListInt()
        
        var firstCalendarLinkNum = ""
        var secondCalendarLinkNum = ""
        
        if(monthListInt[master.selectedRow] < currentMonth){
            year = year + 1
        } else {
            year = currentYear
        }
        
        if(monthListInt[master.selectedRow] == 12){
            firstCalendarLinkNum = "\(year)" + "1201"
            secondCalendarLinkNum = "\(year+1)" + "0101"
        }
        
        if(monthListInt[master.selectedRow] < 10){
            firstCalendarLinkNum = "\(year)0" + "\(monthListInt[master.selectedRow])" + "01"
        } else if (monthListInt[master.selectedRow] >= 10 && monthListInt[master.selectedRow] <= 12){
            firstCalendarLinkNum = "\(year)" + "\(monthListInt[master.selectedRow])" + "01"
        }
        
        if(monthListInt[master.selectedRow] + 1 < 10){
            secondCalendarLinkNum = "\(year)0" + "\(monthListInt[master.selectedRow] + 1)" + "01"
        } else if (monthListInt[master.selectedRow] >= 10 && monthListInt[master.selectedRow] < 12){
            secondCalendarLinkNum = "\(year)" + "\(monthListInt[master.selectedRow] + 1)" + "01"
        }
        
        let URL = Foundation.URL(string: "https://calendar.google.com/calendar/htmlembed?src=nilesk12.org_3vfollsrugrp2l6ee8sbunr4kk@group.calendar.google.com&ctz=America/Chicago&mode=AGENDA&dates=" + firstCalendarLinkNum + "/" + secondCalendarLinkNum)
        //let requestObj = NSURLRequest(URL: URL!);
        //WebView.loadRequest(requestObj);
        //NSLog("\(monthListInt[master.selectedRow])")
        let urlToString: String = URL!.absoluteString
        //NSLog(urlToString)
        
        let myURLString = urlToString
        guard let myURL = Foundation.URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL)
            _ = try HTMLDocument(string: myHTMLString, encoding: String.Encoding.utf8)
            //NSLog("\(myHTMLString)")
            
            //time
            if myHTMLString.range(of: "<td class=\"event-time\">") != nil{
                let searchstr = "<td class=\"event-time\">"
                let ranges: [NSRange]
                
                do {
                    // Create the regular expression.
                    let regex = try NSRegularExpression(pattern: searchstr, options: [])
                    
                    // Use the regular expression to get an array of NSTextCheckingResult.
                    // Use map to extract the range from each result.
                    ranges = regex.matches(in: myHTMLString, options: [], range: NSMakeRange(0, myHTMLString.characters.count)).map {$0.range}
                }
                catch {
                    // There was a problem creating the regular expression
                    ranges = []
                }
                
                let searchend = "m<"
                let endRanges: [NSRange]
                
                do {
                    // Create the regular expression.
                    let regex = try NSRegularExpression(pattern: searchend, options: [])
                    
                    // Use the regular expression to get an array of NSTextCheckingResult.
                    // Use map to extract the range from each result.
                    endRanges = regex.matches(in: myHTMLString, options: [], range: NSMakeRange(0, myHTMLString.characters.count)).map {$0.range}
                }
                catch {
                    // There was a problem creating the regular expression
                    endRanges = []
                }
                if(endRanges.count == 0 || ranges.count == 0){
                    
                } else if endRanges.count >= ranges.count{
                    for i in 0...ranges.count-1{
                        if endRanges.count != 0 && ranges.count != 0{
                            let startOfTimeStamp1 = ranges[i].location + ranges[i].length
                            let endOfTimeStamp1 = endRanges[i].location + 1
                            let indexStartOfText = myHTMLString.characters.index(myHTMLString.startIndex, offsetBy: startOfTimeStamp1)
                            let indexEndOfText = myHTMLString.characters.index(myHTMLString.endIndex, offsetBy: endOfTimeStamp1 - myHTMLString.characters.count)
                            let subString1 = myHTMLString.substring(to: indexEndOfText)
                            let subString2 = subString1.substring(from: indexStartOfText)
                            eventTime.append(subString2)
                            //NSLog(subString2)
                        } else {
                            break
                        }
                    }
                } else {
                    for i in 0...endRanges.count-1{
                        if endRanges.count != 0 && ranges.count != 0{
                            let startOfTimeStamp1 = ranges[i].location + ranges[i].length
                            let endOfTimeStamp1 = endRanges[i].location + 1
                            let indexStartOfText = myHTMLString.characters.index(myHTMLString.startIndex, offsetBy: startOfTimeStamp1)
                            let indexEndOfText = myHTMLString.characters.index(myHTMLString.endIndex, offsetBy: endOfTimeStamp1 - myHTMLString.characters.count)
                            let subString1 = myHTMLString.substring(to: indexEndOfText)
                            let subString2 = subString1.substring(from: indexStartOfText)
                            eventTime.append(subString2)
                            //NSLog(subString2)
                        } else {
                            break
                        }
                    }
                }
            }
            
            //date
            if myHTMLString.range(of: "<div class=\"date\">") != nil{
                let searchstr = "<div class=\"date\">"
                let ranges1: [NSRange]
                
                do {
                    // Create the regular expression.
                    let regex = try NSRegularExpression(pattern: searchstr, options: [])
                    
                    // Use the regular expression to get an array of NSTextCheckingResult.
                    // Use map to extract the range from each result.
                    ranges1 = regex.matches(in: myHTMLString, options: [], range: NSMakeRange(0, myHTMLString.characters.count)).map {$0.range}
                }
                catch {
                    // There was a problem creating the regular expression
                    ranges1 = []
                }
                
                //print("ranges: \(ranges1)")
                
                let searchend = ", \(year)</div>"
                let endRanges1: [NSRange]
                
                do {
                    // Create the regular expression.
                    let regex = try NSRegularExpression(pattern: searchend, options: [])
                    
                    // Use the regular expression to get an array of NSTextCheckingResult.
                    // Use map to extract the range from each result.
                    endRanges1 = regex.matches(in: myHTMLString, options: [], range: NSMakeRange(0, myHTMLString.characters.count)).map {$0.range}
                }
                catch {
                    // There was a problem creating the regular expression
                    endRanges1 = []
                }
                //print("end ranges : \(endRanges1)")
                if(endRanges1.count == 0 || ranges1.count == 0){
                    
                } else if endRanges1.count >= ranges1.count{
                    for i in 0...ranges1.count-1{
                        if endRanges1.count != 0 && ranges1.count != 0{
                            let startOfTimeStamp2 = ranges1[i].location + ranges1[i].length
                            let endOfTimeStamp2 = endRanges1[i].location + 6
                            let indexStartOfText1 = myHTMLString.characters.index(myHTMLString.startIndex, offsetBy: startOfTimeStamp2)
                            let indexEndOfText1 = myHTMLString.characters.index(myHTMLString.endIndex, offsetBy: endOfTimeStamp2 - myHTMLString.characters.count)
                            let subString1 = myHTMLString.substring(to: indexEndOfText1)
                            let subString2 = subString1.substring(from: indexStartOfText1)
                            eventDate.append(subString2)
                            //NSLog(subString2)
                        } else {
                           break
                        }
                    }
                } else {
                    for i in 0...endRanges1.count-1{
                        if endRanges1.count != 0 && ranges1.count != 0{
                            let startOfTimeStamp2 = ranges1[i].location + ranges1[i].length
                            let endOfTimeStamp2 = endRanges1[i].location + 6
                            let indexStartOfText1 = myHTMLString.characters.index(myHTMLString.startIndex, offsetBy: startOfTimeStamp2)
                            let indexEndOfText1 = myHTMLString.characters.index(myHTMLString.endIndex, offsetBy: endOfTimeStamp2 - myHTMLString.characters.count)
                            let subString1 = myHTMLString.substring(to: indexEndOfText1)
                            let subString2 = subString1.substring(from: indexStartOfText1)
                            eventDate.append(subString2)
                            //NSLog(subString2)
                        } else {
                            break
                        }
                    }
                }
            }
            
            //event summary
            if myHTMLString.range(of: "<span class=\"event-summary\">") != nil{
                let searchstr = "<span class=\"event-summary\">"
                let ranges2: [NSRange]
                
                do {
                    // Create the regular expression.
                    let regex = try NSRegularExpression(pattern: searchstr, options: [])
                    
                    // Use the regular expression to get an array of NSTextCheckingResult.
                    // Use map to extract the range from each result.
                    ranges2 = regex.matches(in: myHTMLString, options: [], range: NSMakeRange(0, myHTMLString.characters.count)).map {$0.range}
                }
                catch {
                    // There was a problem creating the regular expression
                    ranges2 = []
                }
                
                //print("ranges: \(ranges2)")
                
                let searchend = "</span></a></div></td></tr></table></div>"
                let endRanges2: [NSRange]
                
                do {
                    // Create the regular expression.
                    let regex = try NSRegularExpression(pattern: searchend, options: [])
                    
                    // Use the regular expression to get an array of NSTextCheckingResult.
                    // Use map to extract the range from each result.
                    endRanges2 = regex.matches(in: myHTMLString, options: [], range: NSMakeRange(0, myHTMLString.characters.count)).map {$0.range}
                }
                catch {
                    // There was a problem creating the regular expression
                    endRanges2 = []
                }
                //print("end ranges : \(endRanges2)")
                if(endRanges2.count == 0 || ranges2.count == 0){
                    
                } else if endRanges2.count >= ranges2.count{
                    for i in 0...ranges2.count-1{
                        if endRanges2.count != 0 && ranges2.count != 0{
                            let startOfTimeStamp3 = ranges2[i].location + ranges2[i].length
                            let endOfTimeStamp3 = endRanges2[i].location
                            let indexStartOfText2 = myHTMLString.characters.index(myHTMLString.startIndex, offsetBy: startOfTimeStamp3)
                            let indexEndOfText2 = myHTMLString.characters.index(myHTMLString.endIndex, offsetBy: endOfTimeStamp3 - myHTMLString.characters.count)
                            let subString2 = myHTMLString.substring(to: indexEndOfText2)
                            let subString3 = subString2.substring(from: indexStartOfText2)
                            eventName.append(subString3)
                            //NSLog(subString3)
                        } else {
                            break
                        }
                    }
                } else {
                    for i in 0...endRanges2.count-1{
                        if endRanges2.count != 0 && ranges2.count != 0{
                            let startOfTimeStamp3 = ranges2[i].location + ranges2[i].length
                            let endOfTimeStamp3 = endRanges2[i].location
                            let indexStartOfText2 = myHTMLString.characters.index(myHTMLString.startIndex, offsetBy: startOfTimeStamp3)
                            let indexEndOfText2 = myHTMLString.characters.index(myHTMLString.endIndex, offsetBy: endOfTimeStamp3 - myHTMLString.characters.count)
                            let subString2 = myHTMLString.substring(to: indexEndOfText2)
                            let subString3 = subString2.substring(from: indexStartOfText2)
                            eventName.append(subString3)
                            //NSLog(subString3)
                        } else {
                            break
                        }
                    }
                }
            }
            
            
            /*for script in doc.xpath("/html/body/div[4]") {
            
            }*/
            
        } catch let error as NSError {
            print(error)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.eventName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventTableViewCell
        
        if(eventName.count > eventTime.count){
            let numOfDiff = eventName.count - eventTime.count
            for _ in 0...numOfDiff {
                eventTime.append("Time not available")
            }
        }
        
        let date = eventDate[indexPath.row]
        let time = eventTime[indexPath.row]
        let name = eventName[indexPath.row]
        cell.dateLabel?.text = date
        cell.nameLabel?.text = name
        cell.timeLabel?.text = time
        
        cell.addToCalendarButtonTapped = {
            
            let alert = UIAlertController(title: "Calendar", message: "Would you like to add this event to the calendar?", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                let yearToAdd = cell.dateLabel.text!.substring(from: cell.dateLabel.text!.characters.index(cell.dateLabel.text!.endIndex, offsetBy: -4))
                var monthInString = cell.dateLabel.text!
                let startIndex = monthInString.characters.index(monthInString.startIndex, offsetBy: 4)
                let endIndex = monthInString.characters.index(monthInString.startIndex, offsetBy: 7)
                monthInString = monthInString[(startIndex ..< endIndex)]
                var monthInNum = "00"
                if(monthInString == "Jan"){
                    monthInNum = "01"
                } else if (monthInString == "Feb"){
                    monthInNum = "02"
                } else if (monthInString == "Mar"){
                    monthInNum = "03"
                } else if (monthInString == "Apr"){
                    monthInNum = "04"
                } else if (monthInString == "May"){
                    monthInNum = "05"
                } else if (monthInString == "Jun"){
                    monthInNum = "06"
                } else if (monthInString == "Jul"){
                    monthInNum = "07"
                } else if (monthInString == "Aug"){
                    monthInNum = "08"
                } else if (monthInString == "Sep"){
                    monthInNum = "09"
                } else if (monthInString == "Oct"){
                    monthInNum = "10"
                } else if (monthInString == "Nov"){
                    monthInNum = "11"
                } else if (monthInString == "Dec"){
                    monthInNum = "12"
                }
                
                var dateInString = cell.dateLabel.text!
                let startIndex1 = dateInString.characters.index(dateInString.endIndex, offsetBy: -8)
                let endIndex1 = dateInString.characters.index(dateInString.endIndex, offsetBy: -6)
                dateInString = dateInString[(startIndex1 ..< endIndex1)].replacingOccurrences(of: " ", with: "0", options: NSString.CompareOptions.literal, range: nil)
                
                let dateString = "\(yearToAdd)-\(monthInNum)-\(dateInString)"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let date = dateFormatter.date(from: dateString)
                
                let eventStore : EKEventStore = EKEventStore()
                
                // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
                
                eventStore.requestAccess(to: EKEntityType.event, completion: {
                    (granted, error) in
                    
                    if (granted) && (error == nil) {
                        
                        let event:EKEvent = EKEvent(eventStore: eventStore)
                        
                        event.title = cell.nameLabel.text!
                        event.startDate = date!
                        event.endDate = date!
                        event.isAllDay = true
                        event.calendar = eventStore.defaultCalendarForNewEvents
                        
                        _ = try? eventStore.save(event, span: EKSpan.thisEvent, commit: true)
                    } 
                })
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
