//
//  ViewController.swift
//  MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgPizza: UIImageView!
    @IBOutlet weak var imgChicken: UIImageView!
    @IBOutlet weak var imgBossam: UIImageView!
    @IBOutlet weak var imgTeok: UIImageView!
    @IBOutlet weak var imgHamburger: UIImageView!
    
    
    @IBOutlet weak var stockPizza: UILabel!
    @IBOutlet weak var stockHamburger: UILabel!
    @IBOutlet weak var stockTeok: UILabel!
    @IBOutlet weak var stockBossam: UILabel!
    @IBOutlet weak var stockChicken: UILabel!
    
    
    @IBOutlet weak var btnBuyTeok: UIButton!
    @IBOutlet weak var btnBuyChicken: UIButton!
    @IBOutlet weak var btnBuyBossm: UIButton!
    @IBOutlet weak var btnBuyHam: UIButton!
    @IBOutlet weak var btnBuyPizza: UIButton!
    
    @IBOutlet weak var btnReset: UIButton!
    
    @IBOutlet weak var receipt: UILabel!
    
    @IBOutlet weak var currentMoney: UILabel!
    
    var imgs : [UIImageView] = []
    var btns : [UIButton] = []
    
    let vender = VendingMachine() // 이 ViewController에서의 vendingmachine 인스턴스
    let NotificationKey = NSNotification.Name(rawValue: "NotificationKey") // Notification의 key를 공통적으로 선언
    let addMoneyKey = NSNotification.Name(rawValue: "changeMoneyKey") // Notification의 key를 공통적으로 선언
    
    let chick = Chicken(shopName: "교촌", capacity: 350, price: 18000, foodName: "허니콤보", dateofManufacture: Date())
    let bossam = Bossam(shopName: "7형제", capacity: 350, price: 25000, foodName: "왕맵보쌈", dateofManufacture: Date())
    let teok = Tteokbokki(shopName: "아딸", capacity: 350, price: 7000, foodName: "떡튀순세트", dateofManufacture: Date())
    let ham = Hamburger(shopName: "버거킹", capacity: 350, price: 8900, foodName: "갈릭스테이크버거", dateofManufacture: Date())
    let pizza = Pizza(shopName: "도미노", capacity: 350, price: 37000, foodName: "불고기피자", dateofManufacture: Date())


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imgs = [imgPizza, imgChicken, imgBossam, imgTeok, imgHamburger]
        btns = [btnBuyChicken,btnBuyHam,btnBuyTeok,btnBuyBossm,btnBuyPizza]
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabelwithRecentStock), name: NotificationKey, object: nil)
        // NotificationKey 라는 이름으로 self에서 Notification이 오면, 내 class안에 있는 updateLabelwithRecentStock이라는 함수를 실행
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabelwithCurrentMoney), name: addMoneyKey, object: nil)
        
        let defaults = UserDefaults.standard
        // 유저디폴트를 불러온다. 
        
        
        if let name = defaults.object(forKey: "test_key") as? [String : Int] { // 유저디폴트에 test_key로 저장된걸 object로 뽑아서 dict으로 형변환해준다.
            vender.setFoodStock(foodStock: name )
            updateLabelwithRecentStock()
        }else { // 유저 디폴트에 없는 경우에만 추가를 해준다.
                       let pizza1 = Pizza(shopName: "도미노", capacity: 350, price: 37000, foodName: "불고기피자", dateofManufacture: Date())
            
            vender.addFood(food: pizza1)
        }
        
       
        
        for img in imgs {
            setImageViewRounded(image: img)
        }
    
        vender.setFoodList(list: [chick,bossam,teok,ham,pizza])
        updateLabelwithCurrentMoney()
        updateLabelwithRecentStock()
        
        btnReset.addTarget(self, action: #selector(ViewController.resetStock), for: .touchUpInside)
       
    }
    
    
    func resetStock(){
        var afterStockList = vender.getFoodStock()
        for (key,_) in afterStockList {
            afterStockList[key] = 1
        }
        vender.setFoodStock(foodStock: afterStockList)
    }
    @IBAction func addChickenPost(_ sender: Any) {
        vender.addFood(food: chick)
        // Notification을 여기서 보내는게 아니라 VendingMachine안에서 post하는 거임.
    }
    
    @IBAction func addBossam(_ sender: Any) {
        vender.addFood(food: bossam)
    }
    @IBAction func addTeok(_ sender: Any) {
        vender.addFood(food: teok)
    }
    @IBAction func addHamburger(_ sender: Any) {
        vender.addFood(food: ham)
    }
    @IBAction func addPizza(_ sender: Any) {
        vender.addFood(food: pizza)
    }
    
    
    func updateLabelwithRecentStock() { // 현재 재고를 찍어준다. 구매내역도.
        self.stockPizza.text = (vender.getFoodStock()["도미노불고기피자"]?.description)! + "개"
        self.stockHamburger.text = (vender.getFoodStock()["버거킹갈릭스테이크버거"]?.description)! + "개"
        self.stockTeok.text = (vender.getFoodStock()["아딸떡튀순세트"]?.description)! + "개"
        self.stockBossam.text = (vender.getFoodStock()["7형제왕맵보쌈"]?.description)! + "개"
        self.stockChicken.text = (vender.getFoodStock()["교촌허니콤보"]?.description)! + "개"
        
        updateSoldList()
        updateBuyButton()
    }
    
    func updateSoldList() {  // 구매내역을 찍어준다.
        let len = vender.getTotalSoldFoodList().count
        
        var cardImage : UIImageView
        if vender.getTotalSoldFoodList() != [] {
            switch vender.getTotalSoldFoodList().last! {
            case "도미노불고기피자" : cardImage = UIImageView(image: #imageLiteral(resourceName: "pizza.png"))
            case "버거킹갈릭스테이크버거" : cardImage = UIImageView(image: #imageLiteral(resourceName: "hamburger.png"))
            case "아딸떡튀순세트" : cardImage = UIImageView(image: #imageLiteral(resourceName: "dduck.png"))
            case "7형제왕맵보쌈" : cardImage = UIImageView(image: #imageLiteral(resourceName: "bossam.png"))
            default : cardImage = UIImageView(image: #imageLiteral(resourceName: "chicken.png"))
            }
            
            cardImage.frame = CGRect(x : 50 * (len - 1), y: 0, width: 140, height: 100)
            self.receipt.addSubview(cardImage)
        }
        
    }
    
    func updateLabelwithCurrentMoney() {
        currentMoney.text = vender.getCurrentMoney().description + "원"
        updateBuyButton()
    }
    
    func updateBuyButton(){ // 구매 가능 불가능 버튼 활성화 
        
        let availableMenu = vender.getAvailableMenuWith()
        
        for btn in btns {
            btn.isEnabled = false;
        }
        
        for food in availableMenu {
            
            if food === chick{
                btnBuyChicken.isEnabled = true
            }else if food === bossam {
                btnBuyBossm.isEnabled = true
            }else if food === teok {
                btnBuyTeok.isEnabled = true
            }else if food === ham {
                btnBuyHam.isEnabled = true
            }else {
                btnBuyPizza.isEnabled = true
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveValue() { // Appdelegate에서 앱이 꺼질때 이 함수를 호출해서 현재 재고를 유저 디폴트에 저장해준다.
        _ = UserDefaults.standard.setValue(vender.getFoodStock(), forKey: "test_key")
    }
    
    @IBAction func addDesposit1000(_ sender: Any) {
        vender.addMoney(amount: 1000)
    }
    
    
    @IBAction func addDeposit5000(_ sender: Any) {
         vender.addMoney(amount: 5000)
    }
    
    
    @IBAction func buyPizza(_ sender: Any) {
        vender.buy(requestfood: pizza)
    }
    
    @IBAction func buyHamburger(_ sender: Any) {
        vender.buy(requestfood: ham)
    }
    
    @IBAction func buyTeok(_ sender: Any) {
        vender.buy(requestfood: teok)
    }
    
    @IBAction func buyBossam(_ sender: Any) {
        vender.buy(requestfood: bossam)
    }
    
    @IBAction func buyChicken(_ sender: Any) {
        vender.buy(requestfood: chick)
    }
    
    func setImageViewRounded(image : UIImageView) {
        image.layer.borderWidth = 5
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
    }
}

