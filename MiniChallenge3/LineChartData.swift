//
//  LineChartData.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osniel Teixeira. All rights reserved.
//

import Foundation

class LineChartData {
    
    var maxCigarettes: Int
    
    var totalDays: Int
    
    var points: [ChartPoint]
    
    var lastValidPoint: ChartPoint
    
    init(points: [ChartPoint]) {
        self.points = points
        self.totalDays = points.count-1
        self.maxCigarettes = points[0].cigarettes
        
        lastValidPoint = points.filter({ $0.cigarettes != -1 }).last!
    }
    
    func getLastValidPointIndex() -> Int {
        return points.index(where: { $0.day == lastValidPoint.day && $0.cigarettes == lastValidPoint.cigarettes })!
    }
    
    func getFormatedDate(_ index: Int) -> String{
        return points[index].getFormattedDate()
    }
}
