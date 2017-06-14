//
//  LineChartData.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osniel Teixeira. All rights reserved.
//

import Foundation
import CoreData

class LineChartData {
    
    var totalDays: Int = 0
    
    var points: [ChartPoint] = []
    
    var lastValidPoint: ChartPoint = ChartPoint(Date())
    
    init() {
        points = getChartPointsFromDatabase().sorted(by: { ($0.day as Date) < ($1.day as Date) })
        self.totalDays = points.count-1
        lastValidPoint = points.filter({ $0.cigarettes != -1 }).last!
    }
    
    func getLastValidPointIndex() -> Int {
        return points.index(where: { $0.day == lastValidPoint.day && $0.cigarettes == lastValidPoint.cigarettes })!
    }
    
    func getFormatedDate(_ index: Int) -> String{
        return points[index].getFormattedDate()
    }
    
    func getMaxCigarettes() -> Int{
        var max = 0
        for p in points{
            if p.cigarettes > max {
                max = p.cigarettes
            }
        }
        return max
    }
    
    func getChartPointsFromDatabase() -> [ChartPoint]{
        var entries: [CigaretteEntry] = []
        do {
            entries = try DatabaseController.persistentContainer.viewContext.fetch(NSFetchRequest(entityName: "CigaretteEntry")) as! [CigaretteEntry]
        } catch _ as NSError {
            print("Error")
        }
        var chartPoints: [ChartPoint] = []
        for p in entries{
            if p.cigaretteNumber != -1{
                chartPoints.append(ChartPoint(p.date! as Date, Int(p.cigaretteNumber)))
            }else{
                chartPoints.append(ChartPoint(p.date! as Date))
            }
        }
        
        return chartPoints
    }

}
