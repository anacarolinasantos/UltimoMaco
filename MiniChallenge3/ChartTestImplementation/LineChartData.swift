//
//  LineChartData.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osniel Teixeira. All rights reserved.
//

import Foundation

class LineChartData {
    
    var totalDays: Int
    
    var points: [ChartPoint]
    
    var lastValidPoint: ChartPoint
    
    init(points: [ChartPoint]) {
        self.points = points
        self.totalDays = points.count-1
        lastValidPoint = points.filter({ $0.cigarettes != -1 }).last!
        
        //quicksort(&self.points, 0, points.count-1)
        
        //lastValidPoint = points.filter({ $0.cigarettes != -1 }).last!
        
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
    
    func partition(_ v: inout [ChartPoint], left: Int, right: Int) -> Int {
        var i = left
        for j in (left + 1)..<(right + 1) {
            if v[j].cigarettes < v[left].cigarettes {
                i += 1
                (v[i], v[j]) = (v[j], v[i])
            }
        }
        (v[i], v[left]) = (v[left], v[i])
        return i
    }
    
    func quicksort(_ v: inout [ChartPoint],_ left: Int,_ right: Int) {
        if right > left {
            let pivotIndex = partition(&v, left: left, right: right)
            quicksort(&v, left, pivotIndex - 1)
            quicksort(&v, pivotIndex + 1, right)
        }
    }

}
