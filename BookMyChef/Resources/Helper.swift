//
//  Helper.swift
//  BookMyChef
//
//  Created by Hassan Abbasi on 18/11/2019.
//  Copyright © 2019 Rove. All rights reserved.
//

import Foundation


class Helper{
    
    
    
    static func convertCusinesToString(cuisine:[String]) ->String {
        var returnString = ""
        
        for cus in cuisine{
            
                returnString = returnString + cus + " | "
            
            
        }
        return String(String(returnString.dropLast()).dropLast())
    }
    
       static func convertDaysToString(days:[String]) -> String{
        
        var DayList = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        if days.count == 6{
           DayList.removeAll { (s) -> Bool in
               return days.contains(s)
            }
            return "Every day of the week except \(DayList[0])"
        }
        
           if days.count == 7{
               return "Every day of the week"
           }
        if days.count == 1{
            return "Available on \(days[0])"
        }
           
           var returnString = "Available on "
           
        for i in 0..<days.count{
            let day = days[i]
            if i == (days.count - 1){
                
                returnString =  "\(String(String(returnString.dropLast()).dropLast())) and \(day)"
            }else{
            
                returnString = returnString + day + ", "}
           }
               
           return returnString
           
           
       }
}
