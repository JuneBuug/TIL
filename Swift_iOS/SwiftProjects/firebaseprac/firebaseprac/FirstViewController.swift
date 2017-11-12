//
//  FirstViewController.swift
//  firebaseprac
//
//  Created by woowabrothers on 2017. 7. 31..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirstViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
   
    var ref: DatabaseReference!
    var item_name = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self
        self.ref = Database.database().reference()
        getItemData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItemData(){
        
        
        ref.child("cs_item").child("1").observe(DataEventType.value, with: { (snapshot) in
            let dict = snapshot.value as?  [String : AnyObject] ?? [:]
            self.item_name = dict["item_name"] as? String ?? ""
            self.mainTable.reloadData()
        })
    
    }
}


extension FirstViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firebaseIdentifier", for: indexPath)
        cell.textLabel?.text = item_name
        return cell
    }
}
