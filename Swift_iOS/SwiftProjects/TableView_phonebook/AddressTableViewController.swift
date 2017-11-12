//
//  AddressTableViewController.swift
//  phoneBookPractice
//
//  Created by woowabrothers on 2017. 7. 13..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class AddressTableViewController: UITableViewController {
    
    private let nameArray = [
        [ "ᄀ" : ["김다인","김수완","김준영","김하은","김형종"] ],
        [ "ᄇ" : ["박예준","박진수"] ],
        [ "ᄉ" : ["서동욱","송통일"] ],
        [ "ᄋ" : ["양재형","오세훈","이단비","이미정","이정웅","이준범"] ], [ "ᄌ" : ["전한나"] ],
        [ "ᄎ" : ["최송이","최혜선"] ],
        [ "ᄒ" : ["한민호","한지웅","홍성호","홍창남","황예린"] ] ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return nameArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        let sth = nameArray[section].values.first
        let row = sth?.count
        
        return row!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let nameArray = self.nameArray[Int(indexPath.section)].first
        cell.textLabel?.text = nameArray?.value[Int(indexPath.row)]
        return cell
    }
 
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let name = self.nameArray[section].first
        
        return name?.key
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
