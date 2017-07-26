//
//  CheckViewController.swift
//  ChickenCountDown
//
//  Created by woowabrothers on 2017. 7. 26..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {
    @IBOutlet weak var inputPhoneNum: UITextField!
    @IBOutlet weak var inputAuth: UITextField!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var checkAuth: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    let rand = RandomNumber()
    let validator = Validator()
    let network = Network()
    var authStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth.isHidden = true
        nextButton.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.init(rawValue: "postSuccess"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer(){
        
    }
    
    @IBAction func sendAuth(_ sender: Any) {
        authStr = rand.makeRandom(num: 6)
        network.dataPost(phonenumber: inputPhoneNum.text!, randNumber: authStr)
        
    }

    @IBAction func validateAuth(_ sender: Any) {
        if validator.isEqual(string1: authStr, string2: inputAuth.text!) {
            checkAuth.isHidden = false
            checkAuth.text = "인증번호가 일치하지 않습니다."
        }else{
            checkAuth.isHidden = true
            nextButton.isEnabled = true
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
