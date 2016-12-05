//
//  CalendarSingleton.swift
//  Dance Marathon
//
//  Created by Danish Arsalan on 2/9/16.
//  Copyright © 2016 Danish Arsalan. All rights reserved.
//

import Foundation

class CalendarSingleton {
    
    static var singleton : CalendarSingleton!;
    
    var monthsList : [String] = ["July", "August", "September", "October", "November", "December", "January", "February", "March", "April", "May", "June"]
    
    var monthsNumberedList : [Int] = [0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0]
    
    var selectedRow = 0
    
    init() {
        CalendarSingleton.singleton = self;
        
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
        
        _ =  CurrentYear().year
        let currentMonth = CurrentMonth().month
        
        //NSLog("\(currentMonth)")
        
        
        
        for j in 0...11 {
            var monthToBeAddedInt = currentMonth + j
            //var numOfMonthsLeft = 0
            if(monthToBeAddedInt > 12){
                monthToBeAddedInt = monthToBeAddedInt - 12
            }
            var monthToBeAddedString = ""
            if(monthToBeAddedInt == 1){
                monthToBeAddedString = "January"
                monthsNumberedList[j] = monthToBeAddedInt
            } else if(monthToBeAddedInt == 2) {
                monthToBeAddedString = "February"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 3) {
                monthToBeAddedString = "March"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 4) {
                monthToBeAddedString = "April"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 5) {
                monthToBeAddedString = "May"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 6) {
                monthToBeAddedString = "June"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 7) {
                monthToBeAddedString = "July"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 8) {
                monthToBeAddedString = "August"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 9) {
                monthToBeAddedString = "September"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 10) {
                monthToBeAddedString = "October"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 11) {
                monthToBeAddedString = "November"
                monthsNumberedList[j] = monthToBeAddedInt
            }else if(monthToBeAddedInt == 12) {
                monthToBeAddedString = "December"
                monthsNumberedList[j] = monthToBeAddedInt
                //numOfMonthsLeft = 10 - j
            }
            monthsList[j] = monthToBeAddedString
            //NSLog("\(monthsList[j])")
            
        }

    }
    
    static func getSingleton() -> CalendarSingleton {
        
        if let single = singleton {
            return single;
        }
        
        singleton = CalendarSingleton();
        return singleton;
    }
    
    func getMonthsListString() -> Array<String>{
        return CalendarSingleton.getSingleton().monthsList
    }
    
    
    
    func getMonthListInt() -> Array<Int>{
        return monthsNumberedList
    }
    
}
