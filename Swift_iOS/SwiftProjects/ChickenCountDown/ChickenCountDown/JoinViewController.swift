//
//  JoinViewController.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import KeychainSwift

class JoinViewController: UIViewController {
    
    @IBOutlet weak var inputID: UITextField!
    @IBOutlet weak var inputPW: UITextField!
    @IBOutlet weak var inputPW2: UITextField!
    @IBOutlet weak var idCheck: UILabel!
    @IBOutlet weak var pwCheck: UILabel!
    @IBOutlet weak var pw2Check: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    let validator = Validator()
    var user = User()
    var idComplete : Bool = false
    var pwComplete : Bool = false
    var pw2Complete : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        idCheck.isHidden = true
        pwCheck.isHidden = true
        pw2Check.isHidden = true
        // Do any additional setup after loading the view.
     
        enableNext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkAll() {
        if validator.checkLength(str: inputID.text!,length: 4){
            idCheck.isHidden = true
            idComplete = true
        }else{
            idCheck.isHidden = false
            idCheck.text = "ID는 4자 이상이어야합니다."
            idComplete = false
        }
        if validator.checkLength(str: inputPW.text!,length: 6){
            if validator.doesPwContainID(password: inputPW.text!, id: inputID.text!) {
                pwCheck.isHidden = false
                pwCheck.text = "PW는 ID를 포함하면 안됩니다."
                pwComplete = false
            }else{
                pwCheck.isHidden = true
                pwComplete = true
            }
        }else{
            pwCheck.isHidden = false
            pwCheck.text = "PW는 6자 이상이어야합니다."
            pwComplete = false
        }
        if validator.isEqual(string1: inputPW.text!, string2: inputPW2.text!){
            pw2Check.isHidden = true
            pw2Complete = true
        }else{
            pw2Check.isHidden = false
            pw2Complete = false
        }
        
        
        enableNext()
    }
    
    func enableNext(){
        if idComplete && pwComplete && pw2Complete {
            nextButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func onIdInputChanged(_ sender: Any) {
        checkAll()
    }
    @IBAction func onPwInputChanged(_ sender: Any) {
        checkAll()
    }
    @IBAction func onPw2InputChanged(_ sender: Any) {
        checkAll()
       
    }
    
    @IBAction func saveUser(_ sender: Any) {
        user.id = inputID.text!
        user.password = inputPW.text!
        
        let keychain = KeychainSwift()
        let user2 = NSKeyedArchiver.archivedData(withRootObject: user)
        keychain.set(user2,forKey: "User")
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
