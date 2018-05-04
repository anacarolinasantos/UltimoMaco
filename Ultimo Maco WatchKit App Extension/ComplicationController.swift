//
//  ComplicationController.swift
//  Ultimo Maco WatchKit App Extension
//
//  Created by Ana Carolina Silva on 03/05/18.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    //MARK: - Timeline configuration
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    //MARK: - Timeline population
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        if complication.family == .circularSmall {
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "5")
            template.fillFraction = Float(5) / 10.0
            template.ringStyle = CLKComplicationRingStyle.closed
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate() as Date, complicationTemplate: template)
            handler(timelineEntry)
        } else {
            handler(nil)
        }
    }
    
    //MARK: - Placeholder templates
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate? = nil
        
        switch complication.family {
        case .modularLarge:
            break
        case .modularSmall:
            break
        case .circularSmall:
            let circularSmallTemplate = CLKComplicationTemplateCircularSmallRingText()
            circularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "5")
            circularSmallTemplate.fillFraction = 0.7
            circularSmallTemplate.ringStyle = .closed
            template = circularSmallTemplate
        case .extraLarge:
            break
        case .utilitarianSmall:
            break
        case .utilitarianSmallFlat:
            break
        case .utilitarianLarge:
            break
        }
        handler(template)
    }
}
