//
//  ViewController.swift
//  MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIApplicationDelegate {

    @IBOutlet weak var defaultValueText: UILabel!
    
    @IBOutlet weak var currentStock: UILabel!
    
    
    let vender = VendingMachine()
    let NotificationKey = NSNotification.Name(rawValue: "NotificationKey")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabelwithRecentStock), name: NotificationKey, object: nil)
        
        let defaults = UserDefaults.standard
        if let name = defaults.object(forKey: "test_key") as? [String : Int] {
            vender.setFoodStock(foodStock: name )
        }else {
            let chick = Chicken(shopName: "교촌", capacity: 350, price: 18000, foodName: "허니콤보", dateofManufacture: Date())
            let pizza1 = Pizza(shopName: "도미노", capacity: 350, price: 37000, foodName: "불고기피자", dateofManufacture: Date())
            
            // vender.addFood(food: chick)
            vender.addFood(food: pizza1)
        }
        
       
        
        self.currentStock.text = vender.getFoodStock().description        
       
    }
    
    @IBAction func saveDefaultValue(_ sender: Any) {
//         _ = UserDefaults.standard.setValue("test_value", forKey: "test_key")
    }
    
    @IBAction func getDefaultValue(_ sender: Any) {
//         let defaults = UserDefaults.standard
//        if let name = defaults.value(forKey: "test_key") {
//            self.defaultValueText.text = name as? String
//        }
    }
    
    @IBAction func addChickenPost(_ sender: Any) {
        
         let chick = Chicken(shopName: "배민", capacity: 350, price: 23000, foodName: "존맛탱구", dateofManufacture: Date())
        vender.addFood(food: chick)
        NotificationCenter.default.post(name: NotificationKey, object: nil)
        
    }
    
    func updateLabelwithRecentStock() {
        self.currentStock.text = vender.getFoodStock().description
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func applicationDidEnterBackground(_ application: UIApplication) {
//       
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
            _ = UserDefaults.standard.setValue(vender.getFoodStock(), forKey: "test_key")

    }

}

