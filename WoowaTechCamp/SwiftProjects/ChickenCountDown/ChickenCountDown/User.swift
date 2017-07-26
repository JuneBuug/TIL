//
//  User.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class User: NSObject, NSCoding {
    
    var id : String
    var password : String
    var phoneNum : String
    var dDate : Date
    
    override init(){
        id = ""
        password = ""
        phoneNum = ""
        dDate = Date()
        
    }
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as! String
        password = aDecoder.decodeObject(forKey: "password") as! String
        phoneNum = aDecoder.decodeObject(forKey: "phoneNum") as! String
        dDate = aDecoder.decodeObject(forKey: "dDate") as! Date
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(phoneNum, forKey: "phoneNum")
        aCoder.encode(dDate, forKey: "dDate")
    }
    
    static func ==(lhs : User, rhs: User) -> Bool{
        if lhs.id == rhs.id && lhs.password  == rhs.password && lhs.phoneNum == rhs.phoneNum && lhs.dDate == rhs.dDate {
            return true
        }else{
            return false
        }
    }
    
}
