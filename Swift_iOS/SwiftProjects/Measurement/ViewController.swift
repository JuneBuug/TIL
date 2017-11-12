//
//  ViewController.swift
//  ConvertMeasure
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var valueTobeConverted: UITextField!
    @IBOutlet weak var finalValueView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func convertFromOunce(_ sender:Any) {
        let ounceValue = Double((self.valueTobeConverted?.text)!)
        var ounce = Measurement(value : ounceValue!, unit: UnitVolume.fluidOunces)
        ounce.convert(to: UnitVolume.milliliters)
        
        self.finalValueView.text = String(describing: ounce)
    }
}

