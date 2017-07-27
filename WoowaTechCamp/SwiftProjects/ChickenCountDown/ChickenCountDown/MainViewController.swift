//
//  MainViewController.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import KeychainSwift


class MainViewController: UIViewController {

    let keychain = KeychainSwift()
    var user = User()
    let validator = Validator()
    
    @IBOutlet weak var countDown: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        getFromKeyChain()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFromKeyChain(){
        let data = keychain.getData("User")
        user = NSKeyedUnarchiver.unarchiveObject(with: data!) as! User
        setValuetoCountDown(date: user.dDate)
    }
    

    func setValuetoCountDown(date : Date){
        let leftDays = validator.checkLeftDays(date: date)
        countDown.text = leftDays.description
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
