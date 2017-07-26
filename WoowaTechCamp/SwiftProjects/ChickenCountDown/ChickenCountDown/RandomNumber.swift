//
//  RandomNumber.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class RandomNumber{
    
    func makeRandom(num : Int) -> String {
        
        var str = ""
        
        for _ in 0..<num{
            let rand = Int(0 + arc4random_uniform(9))
            str.append(String(rand))
        }
        
        return str
    }
}
