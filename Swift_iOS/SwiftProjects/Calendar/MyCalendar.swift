//
//  MyCalendar.swift
//  calendarExample
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class MyCalendar{
    
   
    
    func getTodayInNumber() -> (year : Int, month: Int, day: Int, hour: Int, minute: Int, second: Int){
        
        let today = Date()
        
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: today)
        
        
        return (year:component.year!,month:component.month!,day:component.day!,hour: component.hour!,minute:component.minute!,second:component.second!)
    }
    
    func getDatefromString(yearMonthDay : String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = TimeZone(secondsFromGMT: -9 * 60 * 60)
        
        let dateFromString = formatter.date(from: yearMonthDay)
        
        let today = Date()
        if dateFromString != nil {
            return dateFromString!
        }
        return today
    }
    
    func getDatefromInt(year : Int, month: Int, day: Int ) -> Date{
        
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: -9 * 60 * 60)!
        var comp = DateComponents()
        
        comp.year = year
        comp.month = month
        comp.day = day
        
        return cal.date(from: comp)!
    }
    
    func getKoreanDatefromDate (inputDate : Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let comp = calendar.dateComponents([.year,.month,.day], from: inputDate)
        

        return "\(comp.year!)년 \(comp.month!)월 \(comp.day!)일입니다."
       
    }
    
    func getFirstDayWeekDay (year : Int, month: Int) -> String{
        
        let cal = Calendar(identifier: .gregorian)
        let comp = cal.dateComponents([.weekday], from: getDatefromInt(year: year, month: month, day: 1))
        
        switch comp.weekday!{
            case 1 : return "일요일"
            case 2: return "월요일"
            case 3: return "화요일"
            case 4: return "수요일"
            case 5: return "목요일"
            case 6: return "금요일"
            default : return "토요일"
        }
    }
    
    func getCalendarFromYearMonth (year: Int, month: Int) -> [[Int]] {
        
        var result = [[Int]]()
        let comp = DateComponents(year: year, month: month)
        let cal = Calendar(identifier: .gregorian)
        let mDate = cal.date(from: comp)!
        
        
        let mRange = cal.range(of: .day, in: .month, for: mDate)!
        
        var row = [Int]()
        
        for index in mRange.lowerBound..<mRange.upperBound{
            let mComp = cal.dateComponents([.weekday], from: getDatefromInt(year: year,month: month,day: index))
            
            if mComp.weekday == 1 {
                result.append(row)
                row = []
                row.append(index)
            } else if index == mRange.upperBound - 1 {
                row.append(index)
                result.append(row)

            } else {
                row.append(index)

            }
           
        }
        return result
    }
    
}
