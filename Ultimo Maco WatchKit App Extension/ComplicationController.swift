//
//  ComplicationController.swift
//  Ultimo Maco WatchKit App Extension
//
//  Created by Ana Carolina Silva on 03/05/18.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    //MARK: - Properties
    //FIXME: Put values from CoreData
    let cigarettesSmoked = 5
    let dailyGoal = 10
    let daysToStop = 20
    
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
        let textProvider = CLKSimpleTextProvider(text: cigarettesSmoked.description)
        let fill = Float(cigarettesSmoked/dailyGoal)
        
        switch complication.family {
        case .modularLarge:
            break
        case .modularSmall:
            let modularSmallTemplate = CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider = textProvider
            modularSmallTemplate.fillFraction = fill
            modularSmallTemplate.ringStyle = .closed
            
            template = modularSmallTemplate
        case .circularSmall:
            let circularSmallTemplate = CLKComplicationTemplateCircularSmallRingText()
            circularSmallTemplate.textProvider = textProvider
            circularSmallTemplate.fillFraction = fill
            circularSmallTemplate.ringStyle = .closed
            
            template = circularSmallTemplate
        case .extraLarge:
            let extraLargeTemplate = CLKComplicationTemplateExtraLargeRingText()
            extraLargeTemplate.textProvider = textProvider
            extraLargeTemplate.fillFraction = fill
            extraLargeTemplate.ringStyle = .closed
            
            template = extraLargeTemplate
        case .utilitarianSmall:
            let utilitarianSmallTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            utilitarianSmallTemplate.textProvider = textProvider
            utilitarianSmallTemplate.fillFraction = fill
            utilitarianSmallTemplate.ringStyle = .closed
            
            template = utilitarianSmallTemplate
        case .utilitarianLarge:
            break
        default:
            break
        }
        handler(template)
    }
}
