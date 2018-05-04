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
            template.fillFraction = 5 / 10
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
            
            //TODO: - Modify text provider based on how many cigarettes the user smoked
            circularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "5")
            //TODO: - Modify fill fraction based on (how many cigarettes smoked)/(daily goal)
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
