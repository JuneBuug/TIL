//
//  AddressMainViewController.swift
//  phoneBookPractice
//
//  Created by woowabrothers on 2017. 7. 17..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import AVFoundation

class AddressMainViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let synthesizer = AVSpeechSynthesizer()

    var nameArray = [
        [ "ᄀ" : ["김다인","김수완","김준영","김하은","김형종"] ],
        [ "ᄇ" : ["박예준","박진수"] ],
        [ "ᄉ" : ["서동욱","송통일"] ],
        [ "ᄋ" : ["양재형","오세훈","이단비","이미정","이정웅","이준범"] ], [ "ᄌ" : ["전한나"] ],
        [ "ᄎ" : ["최송이","최혜선"] ],
        [ "ᄒ" : ["한민호","한지웅","홍성호","홍창남","황예린"] ] ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.table.dataSource = self as! UITableViewDataSource
        self.table.delegate = self as! UITableViewDelegate
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func speakSomething(name: String) {
        synthesizer.stopSpeaking(at: .immediate)
        let mutableName : NSMutableString = NSMutableString.init(string: name)
        CFStringTransform(mutableName, nil, kCFStringTransformToLatin, Bool(0))
        let utterance = AVSpeechUtterance(string: String(mutableName))
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddressMainViewController : UITableViewDelegate, UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let sth = nameArray[section].values.first
        let row = sth?.count
        
        return row!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "junekimIdentifier", for: indexPath)
        
        let nameArray = self.nameArray[Int(indexPath.section)].first
        cell.textLabel?.text = nameArray?.value[Int(indexPath.row)]
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath){
        let nameArray = self.nameArray[Int(indexPath.section)].first
        let value = nameArray!.value[Int(indexPath.row)]
        speakSomething(name: value)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row % 2 == 0 {
            return 50.0
        }else {
            return 40.0
        }
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            var arr = nameArray[indexPath.section].first!.value
            arr.remove(at: indexPath.row)
            let key1 = nameArray[indexPath.section].first
//            nameArray[indexPath.section].first!.updateValue(arr)
            
//            nameArray.remove(at: nameArray[indexPath.section].first?.value[indexPath.row])
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            tableView.reloadData()
        }
    }
    
}
