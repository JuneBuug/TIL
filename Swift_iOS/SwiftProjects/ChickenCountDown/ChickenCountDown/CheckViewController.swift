//
//  CheckViewController.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import KeychainSwift

class CheckViewController: UIViewController {
    @IBOutlet weak var inputPhoneNum: UITextField!
    @IBOutlet weak var inputAuth: UITextField!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var checkAuth: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var sendAuth: UIButton!
    @IBOutlet weak var validateAuth: UIButton!
    
    let rand = RandomNumber()
    let validator = Validator()
    let network = Network()
    var user = User()
    var authStr = ""
    
    var seconds = 30
    var timerInstance = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth.isHidden = true
        nextButton.isEnabled = false
        validateAuth.isEnabled = false
        sendAuth.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.init(rawValue: "postSuccess"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPhoneNumChanged(_ sender: Any) {
        if validator.isValidPhoneNumber(num: inputPhoneNum.text!) {
            checkAuth.isHidden = true
            sendAuth.isEnabled = true
        }else{
            checkAuth.isHidden = false
            checkAuth.text =  "올바른 휴대전화번호를 입력해주세요."
            sendAuth.isEnabled = false
        }
    }
    
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timerInstance = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CheckViewController.updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    func updateTimer(){
        validateAuth.isEnabled = true
        if seconds <= 0 {
            self.timerInstance.invalidate()
            validateAuth.isEnabled = false
            nextButton.isEnabled = false
        }else{
            seconds -= 1
            timer.text  = seconds.description
            if seconds < 10 {
                timer.text = "0\(seconds)"
            }
        }
    }
    
    
    @IBAction func sendAuth(_ sender: Any) {
        authStr = rand.makeRandom(num: 6)
        network.dataPost(phonenumber: inputPhoneNum.text!, randNumber: authStr)
        saveToKeyChain()
        seconds = 30
    }

    @IBAction func validateAuth(_ sender: Any) {
        if validator.isEqual(string1: authStr, string2: inputAuth.text!) {
            checkAuth.isHidden = false
            checkAuth.text = "인증이 완료되었습니다."
            nextButton.isEnabled = true
        }else{
            checkAuth.isHidden = false
            checkAuth.text = "인증번호가 일치하지 않습니다."
            nextButton.isEnabled = false
        }
    }
    
     func saveToKeyChain() {
       
        let keychain = KeychainSwift()
        let data = keychain.getData("User")
        let user = NSKeyedUnarchiver.unarchiveObject(with: data!) as! User
        user.phoneNum = inputPhoneNum.text!
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
