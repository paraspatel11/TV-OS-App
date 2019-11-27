//
//  TableViewController.swift
//  Assignment2
//
//  Created by Xcode User on 2019-11-26.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let getData = GetData()
    var timer : Timer!
    
    @IBOutlet var myTable : UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshTable), userInfo: nil, repeats: true)
        
        getData.JSONParser()
        
    }
    
    @objc func refreshTable(){
        if(getData.dbData != nil){
            if(getData.dbData!.count > 0){
                myTable.reloadData()
                timer.invalidate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if getData.dbData != nil{
            return getData.dbData!.count
        }
        else{
            return 0
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MyDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? MyDataTableViewCell ?? MyDataTableViewCell(style: .default, reuseIdentifier: "myCell")
        
        let rowData = getData.dbData![indexPath.row] as NSDictionary
        
        cell.myName.text = rowData["Name"] as? String
        cell.myScore.text = rowData["Score"] as? String
        cell.myTime.text = rowData["Time"] as? String
        
        let displaylogo = rowData["Logo"] as? String
        print(displaylogo ?? " ")
        
        cell.myLogo.image = UIImage(named: displaylogo ?? "Male.jpeg")
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
