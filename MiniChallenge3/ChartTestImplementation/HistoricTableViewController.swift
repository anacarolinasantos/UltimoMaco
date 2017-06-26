//
//  HistoricTableViewController.swift
//  MiniChallenge3
//
//  Created by Osniel Lopes Teixeira on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class HistoricTableViewController: UITableViewController, CustomCellUpdater {
    
    @IBOutlet var theTableView: UITableView!
    var chartData = LineChartData()
    var cellIdentifiers: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let c = chartData.points.filter({ $0.day <= Date() }).count - 1
        cellIdentifiers = Array(repeating: "cell", count: c)
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
            
            if indexPath.row < getPickerIndex(){
                cell.awakeFromNib(chartData.points[indexPath.row + 1])
            }else{
                cell.awakeFromNib(chartData.points[indexPath.row])
            }
            return cell
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "picker", for: indexPath) as? PickerTableViewCell  else {
                fatalError("The dequeued cell is not an instance of PickerTableViewCell.")
            }
            cell.awakeFromNib(self,chartData.points[indexPath.row].day,chartData.points[indexPath.row].cigarettes)
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
        
        if touchedRow != cellIdentifiers.count-1{
            if cellIdentifiers[touchedRow + 1] == "picker"{
                cellIdentifiers.remove(at: touchedRow + 1)
                let newIndexPath = IndexPath(row: touchedRow + 1, section: 0)
                tableView.deleteRows(at: [newIndexPath], with: .top)
            }else{
                cellIdentifiers.insert("picker", at: touchedRow + 1)
                let newIndexPath = IndexPath(row: touchedRow + 1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            
        }else{
            cellIdentifiers.insert("picker", at: touchedRow + 1)
            let newIndexPath = IndexPath(row: touchedRow + 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
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
    
    func updateTableView() {
        chartData = LineChartData()
        theTableView.reloadData()
    }
    
    func getPickerIndex() -> Int{
        for i in 0..<cellIdentifiers.count{
            if cellIdentifiers[i] == "picker"{
                return i
            }
        }
        return cellIdentifiers.count
    }
    
}
