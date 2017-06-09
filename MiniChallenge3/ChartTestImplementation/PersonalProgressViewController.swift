//
//  ViewController.swift
//  ChartTestImplementation
//
//  Created by Guilherme Paciulli on 06/06/17.
//  Copyright © 2017 Guilherme Paciulli, Osniel Teixeira. All rights reserved.
//

import UIKit

class PersonalProgressViewController: UIViewController {

    @IBOutlet weak var chart: LineChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = LineChartData(points: [ChartPoint(Date(), 21),
                                          ChartPoint(Calendar.current.date(byAdding: .day, value: 1, to: Date())!, 20),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 2, to: Date())!, 17),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 3, to: Date())!, 19),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 4, to: Date())!, 6),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 5, to: Date())!),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 6, to: Date())!),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 7, to: Date())!),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 8, to: Date())!),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 9, to: Date())!),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 10, to: Date())!, 11),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 11, to: Date())!, 4),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 12, to: Date())!, 3),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 13, to: Date())!, 2),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 14, to: Date())!, 1),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 15, to: Date())!, 7),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 16, to: Date())!, 1),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 17, to: Date())!),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 18, to: Date())!),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 19, to: Date())!, 5),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 20, to: Date())!, 3),
                                        ChartPoint(Calendar.current.date(byAdding: .day, value: 21, to: Date())!, 0)])
        chart.pointData = test
    }



}

