//
//  Baedal.swift
//  Baedal
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


class BaedalFood {
    private var shopName : String
    private var capacity : Int
    private var price : Int
    private var foodName : String
    private var dateOfManufacture : Date 

    init(){
        shopName = ""
        capacity = 0
        price = 0
        foodName = ""
        dateOfManufacture = Date()
    }
    
    init(shopName : String, capacity : Int, price : Int, foodName: String, dateofManufacture : Date) {
        self.capacity = capacity
        self.foodName = foodName
        self.shopName = shopName
        self.price = price
        self.dateOfManufacture = dateofManufacture
    }
   
    
    func getFoodName() -> String {
        return self.foodName
    }
    
    func getPrice() -> Int {
        return self.price
    }
    
    func getshopName() -> String{
        return self.shopName
    }
    func setFoodName(name : String){
        self.foodName = name
    }

    func setPrice(price : Int) {
        self.price = price
    }
    
    static func ==(left: BaedalFood , right: BaedalFood) -> Bool {
        if left.shopName == right.shopName && left.capacity == right.capacity && left.foodName == right.foodName && left.price == right.price && left.dateOfManufacture == right.dateOfManufacture {
            return true
        }else{
            return false
        }
        
    }
}

class Pizza : BaedalFood {
    
    private var dough : String
    
    override init(){
        self.dough = ""
        super.init()
    }
    override init(shopName : String, capacity : Int, price : Int, foodName: String, dateofManufacture : Date) {
        self.dough = "씬"
        super.init(shopName: shopName, capacity: capacity, price: price, foodName: foodName, dateofManufacture: dateofManufacture)
    }
}


class Chicken : BaedalFood {
    
    override init(){
        super.init()
    }
    override init(shopName : String, capacity : Int, price : Int, foodName: String, dateofManufacture : Date) {
        super.init(shopName: shopName, capacity: capacity, price: price, foodName: foodName, dateofManufacture: dateofManufacture)
    }
}

class Bossam : BaedalFood {
    
    override init(){
        super.init()
    }
    override init(shopName : String, capacity : Int, price : Int, foodName: String, dateofManufacture : Date) {
        super.init(shopName: shopName, capacity: capacity, price: price, foodName: foodName, dateofManufacture: dateofManufacture)
    }
}

class Hamburger : BaedalFood {
    
    override init(){
        super.init()
    }
    override init(shopName : String, capacity : Int, price : Int, foodName: String, dateofManufacture : Date) {
        super.init(shopName: shopName, capacity: capacity, price: price, foodName: foodName, dateofManufacture: dateofManufacture)
    }
}

class Tteokbokki : BaedalFood {
    
    override init(){
        super.init()
    }
    override init(shopName : String, capacity : Int, price : Int, foodName: String, dateofManufacture : Date) {
        super.init(shopName: shopName, capacity: capacity, price: price, foodName: foodName, dateofManufacture: dateofManufacture)
    }
    
    
}


