//
//  VendinMachine.swift
//  Baedal
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation



class VendingMachine {
    private var foodList : [BaedalFood] = []
    private var foodStockList : [String : Int] = [:]
    private var soldFoodList : [String : Int] = [:]
    private var totalSoldList : [BaedalFood] = []
    
    // 음식 추가
    func addFood(food : BaedalFood){
        
        let stockNum = foodStockList[food.getshopName()+food.getFoodName()]
        
        // 이전에 추가한 적이 있었다는 뜻이므로
        if stockNum != nil {
            foodStockList[food.getshopName()+food.getFoodName()] = stockNum! + 1
        }else{
            foodStockList[food.getshopName()+food.getFoodName()] = 1
            foodList.append(food)
        }
    }
    
    func getFoodStock() -> [String : Int] {
        return foodStockList
    }
    
    func setFoodStock(foodStock: [String: Int]) {
        foodStockList = foodStock
    }
    
    // 금액을 입력하면 구매 가능한 음식 목록 리턴. 재고가 없을 때도 고려
    
    func getAvailableMenuWith (money : Int) -> [BaedalFood] {
        let cheapFoodList = foodList.filter( { $0.getPrice() <= money })
        var availableFoodList = cheapFoodList
        
        for food in cheapFoodList {
            if ( foodStockList[food.getshopName()+food.getFoodName()] == 0 ){
                availableFoodList = cheapFoodList.filter({ $0 !== food})
            }
        }
        
        return availableFoodList
    }
    
    // 특정 음식을 구매하면 먼저 구매 가능한지 보고, 잔액을 리턴
    func buy(requestfood : BaedalFood,money : Int) -> Int {
        
        let availableFoodlist = getAvailableMenuWith(money: money)
        
        for food in availableFoodlist {
            
            let keyName = food.getshopName()+food.getFoodName()
            if food == requestfood {
                
                foodStockList[keyName] = foodStockList[keyName]! - 1
                
                if soldFoodList[keyName] == nil {
                    soldFoodList[keyName] = food.getPrice()
                }
                
                totalSoldList.append(requestfood)
                
                return money - food.getPrice()
            }
        }
        
        return -1
    }
    
    
    func getTotalSoldFoodList() -> [String]{
        
        return turnFoodListToNameList(foodlist: totalSoldList)
    }
    
    
    // Food List를 해당가게+메뉴명으로 바꿔주는 함수
    func turnFoodListToNameList(foodlist : [BaedalFood]) -> [String]{
        
        var result : [String] = []
        for food in foodlist{
            result.append(food.getshopName()+food.getFoodName())
        }
        
        return result
    }
    

}
