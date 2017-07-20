//
//  ViewController.swift
//  baeminFresh
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var mainJson : Array<Dictionary<String,Any>> = []
    var courseJson : Array<Dictionary<String,Any>> = []
    var sideJson : Array<Dictionary<String,Any>> = []
    var soupJson : Array<Dictionary<String,Any>> = []
    
    let notiKey = NSNotification.Name(rawValue: "dataGetComplete")
    let imageKey = NSNotification.Name(rawValue: "imageDownloadComplete")
    let network = Network()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.table.dataSource = self as UITableViewDataSource
        self.table.delegate = self as UITableViewDelegate
        
    
        
        let urls = ["http://52.78.212.27:8080/woowa/main","http://52.78.212.27:8080/woowa/course","http://52.78.212.27:8080/woowa/side","http://52.78.212.27:8080/woowa/soup"]
        
        for url in urls {
            let filename = url.components(separatedBy: "/").last
            network.alamoGetJsonfromURL(url: url, filename: filename!)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(processJson(_:)), name: notiKey, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: imageKey, object: nil)

        //        parseJson(model: &mainJson ,filename : "main")
        //        parseJson(model: &courseJson,filename : "course")
        //        parseJson(model: &sideJson, filename : "side")
        //        parseJson(model: &soupJson,filename : "soup")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    func reloadTable(){
        table.reloadData()
    }
    
    func processJson(_ notification: NSNotification) {
        
        if let json = notification.userInfo?["main"] as? Array<Dictionary<String,Any>> {
            mainJson = json
            table.reloadSections([0], with: UITableViewRowAnimation.bottom)
        }else if let json = notification.userInfo?["side"] as? Array<Dictionary<String,Any>>{
            sideJson = json
            table.reloadSections([2], with: UITableViewRowAnimation.bottom)
            
        }else if let json = notification.userInfo?["course"] as? Array<Dictionary<String,Any>>{
            courseJson = json
            table.reloadSections([1], with: UITableViewRowAnimation.bottom)
            
        }else if let json = notification.userInfo?["soup"] as? Array<Dictionary<String,Any>>{
            soupJson = json
            table.reloadSections([3], with: UITableViewRowAnimation.bottom)
        }
        
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProductDetail" {
            if let indexPath = table.indexPathForSelectedRow {
                
                var model : Array<Dictionary<String, Any>> = []
                
                if let section = table.indexPathForSelectedRow?.section{
                    switch section {
                    case 0 : model = mainJson
                    case 1: model = courseJson
                    case 2: model = sideJson
                    default: model = soupJson
                    }
                }
                
                let dict = model[indexPath.row]
                
                let controller = segue.destination as! DetailViewController
                controller.hashfromMaster = dict["detail_hash"] as? String
                controller.titlefromMaster = dict["title"] as? String
            }
        }
    }

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
                
                let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(dict["detail_hash"] as! String + ".jpg")
                cell.mainImageView.image = UIImage(contentsOfFile: fileURL.path)

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
                    cell.s_priceView.text = dict["s_price"] as? String
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
    
    

}
