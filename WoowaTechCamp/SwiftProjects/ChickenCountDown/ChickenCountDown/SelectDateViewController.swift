//
//  SelectDateViewController.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import KeychainSwift

class SelectDateViewController: UIViewController {
    @IBOutlet weak var selectedDate: UIDatePicker!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    let validator = Validator()
    var user = User()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reason.isHidden = true
        nextButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onDatePickerChanged(_ sender: Any) {
        if validator.isFuture(date: selectedDate.date) {
            reason.isHidden = true
            nextButton.isEnabled = true
        }else{
            reason.isHidden = false
            nextButton.isEnabled = false
        }
    }
    @IBAction func onDateChanged(_ sender: Any) {
        if validator.isFuture(date: selectedDate.date) {
            reason.isHidden = true
            nextButton.isEnabled = true
        }else{
            reason.isHidden = false
            nextButton.isEnabled = false
        }
    }
    
    func saveToKeyChain() {
        let keychain = KeychainSwift()
        let data = keychain.getData("User")
        let user = NSKeyedUnarchiver.unarchiveObject(with: data!) as! User
        user.dDate = selectedDate.date
        let user2 = NSKeyedArchiver.archivedData(withRootObject: user)
        keychain.set(user2,forKey: "User")
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UIMainSegue" {
            saveToKeyChain()
        }
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
