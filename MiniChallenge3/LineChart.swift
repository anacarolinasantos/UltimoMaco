//
//  LineChart.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osnielt Teixeira. All rights reserved.
//

import UIKit

class LineChart: UIView {
    
    var pointData: LineChartData?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let pD = pointData {
            drawChart(pointData: pD)
        }
    }
    
    func scale(unitX: Int, unitY: Int) -> CGPoint {
        let y = CGFloat(unitY) * (bounds.height * 0.9) * 0.95 / CGFloat((pointData?.maxCigarettes)!)
        return CGPoint(x: (CGFloat(unitX) * ((bounds.width) - (bounds.height * 0.075))  * 0.95 / (CGFloat(pointData!.totalDays)) + (bounds.height * 0.075)),
                       y: ((bounds.height * 0.9) - y))
    }
 
    func drawChart(pointData: LineChartData) {
        if let context = UIGraphicsGetCurrentContext() {
            drawGoal(context: context, pointData: pointData)
            drawPerformance(context: context, pointData: pointData)
            drawAxes(context: context, pointData: pointData)
        }
    }
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
    func drawAxes(context: CGContext, pointData: LineChartData) {
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(2.5)
        
        //X Axis
        context.move(to: CGPoint(x: 0, y: bounds.height - (bounds.height * 0.1)))
        context.addLine(to: CGPoint(x: bounds.width, y: bounds.height - (bounds.height * 0.1)))
        context.strokePath()
        
        //X labels
        let xStep = pointData.points.count/6
        for i in stride(from: xStep-1, to: (pointData.points).count, by: xStep) {
            let p = (pointData.points[i])
            print(p.getDay())
            var point = scale(unitX: i, unitY: p.cigarettes)
            point.y = bounds.height - (bounds.height * 0.1)
            point.x = point.x - (p.getDay() / 10 > 0 ? 10.2 : 5)
            let rect = CGRect(origin: point, size: CGSize(width: 60, height: 30))
            let label = UILabel(frame: rect)
            label.font = UIFont(name: "Helvetica", size: CGFloat(10.0))
            label.text = p.getFormattedDate()
            self.addSubview(label)
        }
        
        //Y Axis
        context.setLineWidth(2.5)
        context.move(to: CGPoint(x: (bounds.height * 0.075), y: bounds.height))
        context.addLine(to: CGPoint(x: (bounds.height * 0.075), y: 0))
        context.strokePath()
        let fontSize:CGFloat = 10.0
        //let fontSize = distance(scale(unitX: 1, unitY: 1), scale(unitX: 1, unitY: (pointData.maxUnitY))) / CGFloat((pointData.maxUnitY) / 5)
        let font = UIFont(name: "Helvetica", size: fontSize)
        
        //Y labels
        let yStep = pointData.maxCigarettes/4
        for i in stride(from: yStep, through: pointData.maxCigarettes, by: yStep) {
            var point = scale(unitX: 0, unitY: i)
            point.x = point.x - 35
            point.y = point.y - (fontSize / 2)
            
            let rect = CGRect(origin: point, size: CGSize(width: 30, height: fontSize))
            let label = UILabel(frame: rect)
            label.font = font
            label.textAlignment = .right
            
            label.text = String(describing: i)
            self.addSubview(label)
        }
    }
    
    func drawGoal(context: CGContext, pointData: LineChartData) {
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(3)
        let firstPoint = pointData.points[0]
        context.move(to: scale(unitX: 0, unitY: (firstPoint.cigarettes)))
        for i in 1...pointData.totalDays{
            let cigarretsOfToday = -(Int(Double(pointData.maxCigarettes)/Double(pointData.totalDays) * Double(i))) + pointData.maxCigarettes
            let point = scale(unitX: i, unitY: cigarretsOfToday)
            context.addLine(to: point)
            context.move(to: point)
            
        }

        context.strokePath()
    }
    
    func drawPerformance(context: CGContext, pointData: LineChartData) {
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(3)
        context.setLineCap(.butt)
        
        //Moves the pen to te first point
        let firstPoint = pointData.points[0]
        context.move(to: scale(unitX: 0, unitY: (firstPoint.cigarettes)))
        
        var lastValidPoint = scale(unitX: 0, unitY: (firstPoint.cigarettes))
        
        //Draws the lines
        for i in 1...pointData.totalDays {
            let p = (pointData.points[i])
            let lastPoint = (pointData.points[i - 1])
            let point = scale(unitX: i, unitY: p.cigarettes)
            if p.cigarettes != -1 {
                if lastPoint.cigarettes != -1 {
                    context.addLine(to: point)
                    context.strokePath()
                } else {
                    context.setLineDash(phase: 1, lengths: [10, 5])
                    context.setLineWidth(1.5)
                    context.move(to: lastValidPoint)
                    context.addLine(to: point)
                    context.strokePath()
                    context.setLineDash(phase: 0, lengths: [])
                    context.setLineWidth(3)
                }
                lastValidPoint = point
            }
            context.move(to: point)
        }
        
        context.strokePath()
        
        //Draws the circles
        for i in 1...pointData.totalDays {
            let cigarretsOfToday = -(Int(Double(pointData.maxCigarettes)/Double(pointData.totalDays) * Double(i))) + pointData.maxCigarettes
            let p = (pointData.points[i])
            let point = scale(unitX: i, unitY: p.cigarettes)
            if p.cigarettes > 0 {
                if p.cigarettes <= cigarretsOfToday{
                    context.setStrokeColor(UIColor.yellow.cgColor)
                }else{
                    context.setStrokeColor(UIColor.red.cgColor)
                }
                if i == pointData.getLastValidPointIndex() {
                    
                    context.addArc(center: point, radius: 4, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                    context.strokePath()
                    context.setFillColor(UIColor.white.cgColor)
                    context.addArc(center: point, radius: 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                } else {
                    context.addArc(center: point, radius: 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                    context.strokePath()
                    context.setFillColor(UIColor.white.cgColor)
                    context.addArc(center: point, radius: 1, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
                }
                context.fillPath()
                context.strokePath()
            }
        }
    }
}
