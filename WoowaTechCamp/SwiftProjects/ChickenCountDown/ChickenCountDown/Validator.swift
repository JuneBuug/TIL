//
//  Validator.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class Validator{
    
    
    func doesPwContainID(password : String, id : String) -> Bool {
        if password.contains(id){
            return true
        }else{
            return false
        }
    }
    
    func checkLength(str : String, length : Int) -> Bool {
     
        if str.characters.count >= length {
            return true
        }else{
            return false
        }
    }
    
    func isEqual(string1 : String, string2 : String) -> Bool {
        
        if string1 == string2 {
            return true
        }else{
            return false
        }
    }
    
    
    func isValidPhoneNumber(num : String) -> Bool {
        if num.characters.count == 10 || num.characters.count == 11 {
          
            if Int(num) != nil {
                
                let numString = num as NSString
                
                if numString.substring(to: 2) == "01" {
                    
                    if numString.substring(with: NSMakeRange(2, 1)) == "2" || numString.substring(with: NSMakeRange(2, 1)) == "4" {
                        return false
                    }else{
                        return true
                    }
                    
                }else{
                    return false
                }
            }else{
                return false
            }
            
        }else{
            return false
        }
    }
    
    func isFuture(date : Date) -> Bool {
        let today = Date()
        
        if date > today {
            return true
        }else{
            return false
        }
    }
    
    func checkLeftDays(date : Date) -> Int {
        
        let calendar = Calendar(identifier: .gregorian)
        let today = Date()
        let components = calendar.dateComponents([.year,.month,.day], from: today, to: date)
        
        return components.day! + 1
    }
}
