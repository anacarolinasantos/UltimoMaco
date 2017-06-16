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
        return 1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        
        for view in (header.subviews) {
            view.removeFromSuperview()
        }
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width, height: 50))
        
        label.text = "CIGARROS"
        label.textColor = UIColor.gray
        label.font = UIFont(name: "Avenir-Book", size: 12)
        header.addSubview(label)
        header.bringSubview(toFront: label)
        return header
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if cellIdentifiers[indexPath.row] == "cell"{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoricTableViewCell  else {
                fatalError("The dequeued cell is not an instance of HistoricTableViewCell.")
            }
            
            cell.awakeFromNib(chartData.points[indexPath.row + 1])
            return cell
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "picker", for: indexPath) as? PickerTableViewCell  else {
                fatalError("The dequeued cell is not an instance of PickerTableViewCell.")
            }
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        var touchedRow = indexPath.row
        var i = 0
        while i<cellIdentifiers.count{
            if cellIdentifiers[i] == "picker" && i != indexPath.row + 1{
                cellIdentifiers.remove(at: i)
                let newIndexPath = IndexPath(row: i, section: 0)
                tableView.deleteRows(at: [newIndexPath], with: .top)
                if i < touchedRow{
                    touchedRow -= 1
                }
            }else{
                i+=1
            }
        }
        
        if cellIdentifiers[touchedRow + 1] == "picker"{
            cellIdentifiers.remove(at: touchedRow + 1)
            let newIndexPath = IndexPath(row: touchedRow + 1, section: 0)
            tableView.deleteRows(at: [newIndexPath], with: .top)

        }else{
            cellIdentifiers.insert("picker", at: touchedRow + 1)
            let newIndexPath = IndexPath(row: touchedRow + 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .bottom)

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
