//
//  HistoricTableViewController.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class HistoricTableViewController: UITableViewController {
    
    var chartData = LineChartData()
    var cellIdentifiers: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellIdentifiers = Array(repeating: "cell", count: chartData.points.count-1)
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CIGARROS"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellIdentifiers.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.gray
        header.textLabel?.font = UIFont(name: "System", size: 23)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if cellIdentifiers[indexPath.row] == "cell"{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoricTableViewCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            
            cell.awakeFromNib(chartData.points[indexPath.row + 1])
            return cell
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "picker", for: indexPath) as? PickerTableViewCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.beginUpdates()
        if cellIdentifiers[indexPath.row + 1] == "picker"{
            cellIdentifiers.remove(at: indexPath.row + 1)
            let newIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
            tableView.deleteRows(at: [newIndexPath], with: .automatic)
        }else{
            cellIdentifiers.insert("picker", at: indexPath.row+1)
            let newIndexPath = IndexPath(row: indexPath.row+1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellIdentifiers[indexPath.row] == "cell"{
            return 45.0
        }else{
            return 216.0
        }
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
