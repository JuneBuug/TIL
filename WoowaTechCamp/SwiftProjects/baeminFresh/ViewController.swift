//
//  ViewController.swift
//  baeminFresh
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var mainJson : Array<Dictionary<String,Any>> = []
    var courseJson : Array<Dictionary<String,Any>> = []
    var sideJson : Array<Dictionary<String,Any>> = []
    var soupJson : Array<Dictionary<String,Any>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.table.dataSource = self as UITableViewDataSource
        self.table.delegate = self as UITableViewDelegate
        
        parseJson(model: &mainJson ,filename : "main")
        parseJson(model: &courseJson,filename : "course")
        parseJson(model: &sideJson, filename : "side")
        parseJson(model: &soupJson,filename : "soup")
        
        
    }

    
    //model이 let constant라고해서 inout붙이고 &로 포인터 넘겨줌
    func parseJson(model : inout Array<Dictionary<String,Any>>, filename: String) {
        do {
            if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let array = json as? [Any] {
                    // json is an array
                    for object in array {
                        model.append(object as! [String : Any])
                    }
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
        case 0 : return mainJson.count
        case 1: return courseJson.count
        case 2: return sideJson.count
        default: return soupJson.count
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        
        func setCellViewfromJson(model : Array<Dictionary<String,Any>>){
            
            let dict = model[indexPath.row]
            var badgeList = [String]()
            for (key, value) in dict {
                switch key {
                case "title" : cell.titleView.text = value as? String
                case "description" : cell.descriptionView.text = value as? String
                case "s_price" : cell.s_priceView.text = value as? String
                case "badge" : badgeList = value as! [String]
                case "n_price" : cell.n_priceView.text = value as? String
                default : break
                }
            }
            
            if dict.keys.contains("s_price") && dict.keys.contains("n_price") {
                cell.s_priceView.isHidden = false
                cell.n_priceView.isHidden = false
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: dict["n_price"] as! String)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.n_priceView.attributedText = attributeString
                
            }else if dict.keys.contains("s_price") {
                cell.s_priceView.isHidden = false
                cell.s_priceView.text = dict["s_price"] as! String
            }else if dict.keys.contains("n_price"){
                cell.s_priceView.isHidden = false
                cell.s_priceView.text = dict["n_price"] as? String
                
            }
            
            if badgeList.count > 0 {
                if badgeList.contains("론칭특가"){
                    cell.launchinngBadge.isHidden = false
                }
                if badgeList.contains("이벤트특가"){
                    cell.eventBadge.isHidden = false
                }
            }
            
            if cell.s_priceView.text?.characters.last != "원" {
                cell.s_priceView.text?.append("원")
            }
            
        }
        
        switch indexPath.section {
        case 0 : setCellViewfromJson(model: mainJson)
        case 1: setCellViewfromJson(model: courseJson)
        case 2: setCellViewfromJson(model: sideJson)
        default: setCellViewfromJson(model: soupJson)
        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0 : return "밑반찬"
        case 1: return "메인반찬"
        case 2: return "간식"
        default: return "국·찌개"
        }
    
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        if(section == 0) {
//            
//            let view = UIView() // The width will be the same as the cell, and the height should be set in tableView:heightForRowAtIndexPath:
//            let label = UILabel()
//            label.text="My Details"
//            
//            view.addSubview(label)
//           
//            return view
//        }
//        
        return nil
    }
 
}

