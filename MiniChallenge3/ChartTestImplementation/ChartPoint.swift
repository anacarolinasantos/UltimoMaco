//
//  Point.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osniel Teixeira. All rights reserved.
//

import Foundation

class ChartPoint {
    
    var cigarettes: Int
    
    var day: Date
    
    init(_ day: Date,_ cigarettes: Int = -1) {
        self.day = day
        self.cigarettes = cigarettes
    }
    
    func getFormattedDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "pt_BR")
        var date = dateFormatter.string(from: self.day as Date)
        let index = date.index(date.startIndex, offsetBy: 5)
        date = date.substring(to: index)
        return date
    }

    
    func getDay() -> Int{
        let cal = Calendar.current

        return cal.component(.day, from: self.day as Date)
    }
}
