//
//  CalendarHelper.swift
//  CalendarProject
//
//  Created by user228274 on 10/23/22.
//

import Foundation
import UIKit

//functions
class CalendarHelper{
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date{
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date{
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    //return month in string
    //1 Jan 2022 -> January
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func monthDayString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from: date)
    }
    
    
    //return year in string
    //1 Jan 2022 -> 2022
    func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func timeString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    //return number of days in a month
    // Jan -> 31 days
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    //return day of the month
    //1 Jan 2022 -> 1
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func hourFromDate(date: Date) -> Int {
        let components = calendar.dateComponents([.hour], from: date)
        return components.hour!
    }
    
    //24 Jan 2022 -> 1 Jan 2022
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from:components)!
    }
    
    //1 Jan 2022 -> 6 ( Sat )
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func weekDayAsString(date: Date) -> String {
        switch weekDay(date: date)
        {
        case 0:
            return "Sunday"
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return ""
            
        }
    }
    
    
    //find the day that nearest the Sun, case for beginning of the month
    func addDays(date: Date, days: Int) -> Date {
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    func sundayForDate(date: Date) -> Date{
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)
        
        while(current > oneWeekAgo){
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            if currentWeekDay == 1{
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }
}
