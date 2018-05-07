//
//  ComplicationController.swift
//  Ultimo Maco WatchKit App Extension
//
//  Created by Ana Carolina Silva on 03/05/18.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource{
    //MARK: - Properties
    //FIXME: Put values from CoreData
    var cigarettesSmoked = 5
    var dailyGoal = 20
    var daysToStop = 20
    //FIXME: Put image icon with rigth size
    //    let iconImage = UIImage(named: "")
    
    let mainColor = UIColor(red: 43/255, green: 144/255, blue: 166/255, alpha: 1)
    
    //MARK: - Timeline configuration
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    //MARK: - Timeline population
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        self.cigarettesSmoked = WSManager.shared.numberOfCigarretesSmoked
        self.dailyGoal = WSManager.shared.numberOfCigarettesCanSmokeToday
        self.daysToStop = WSManager.shared.numberOfDaysToEnd
        
        let cigarettesSmokedString = String(format: "%02d", self.cigarettesSmoked)
        let dailyGoalString = String(format: "%02d", self.dailyGoal)
        let daysToStopString = String(format: "%02d", self.daysToStop)
        
        var template: CLKComplicationTemplate? = nil
        let textProvider = CLKSimpleTextProvider(text: self.cigarettesSmoked.description)
        let fill = Float(self.cigarettesSmoked)/Float(self.dailyGoal)
        
        switch complication.family {
        case .modularLarge:
            let modularLargeTemplate = CLKComplicationTemplateModularLargeStandardBody()
            //FIXME: Uncomment this line after set iconImage
//            modularLargeTemplate.headerImageProvider = CLKImageProvider(onePieceImage: iconImage)
            modularLargeTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Último Maço!")
            modularLargeTemplate.body1TextProvider = CLKSimpleTextProvider(text: "\(cigarettesSmokedString) cigarros de \(dailyGoalString)")
            modularLargeTemplate.body2TextProvider = CLKSimpleTextProvider(text: "\(daysToStopString) dias para parar!")
            
            modularLargeTemplate.headerTextProvider.tintColor = mainColor
            
            template = modularLargeTemplate
        case .modularSmall:
            let modularSmallTemplate = CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider = textProvider
            modularSmallTemplate.fillFraction = fill
            modularSmallTemplate.ringStyle = .closed
            
            modularSmallTemplate.tintColor = mainColor
            
            template = modularSmallTemplate
        case .circularSmall:
            let circularSmallTemplate = CLKComplicationTemplateCircularSmallRingText()
            circularSmallTemplate.textProvider = textProvider
            circularSmallTemplate.fillFraction = fill
            circularSmallTemplate.ringStyle = .closed
            
            circularSmallTemplate.tintColor = mainColor
            
            template = circularSmallTemplate
        case .extraLarge:
            let extraLargeTemplate = CLKComplicationTemplateExtraLargeRingText()
            extraLargeTemplate.textProvider = textProvider
            extraLargeTemplate.fillFraction = fill
            extraLargeTemplate.ringStyle = .closed
            
            extraLargeTemplate.tintColor = mainColor
            
            template = extraLargeTemplate
        case .utilitarianSmall:
            let utilitarianSmallTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            utilitarianSmallTemplate.textProvider = textProvider
            utilitarianSmallTemplate.fillFraction = fill
            utilitarianSmallTemplate.ringStyle = .closed
            
            utilitarianSmallTemplate.tintColor = mainColor
            
            template = utilitarianSmallTemplate
        case .utilitarianLarge:
            let utilitarianLargeTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            //FIXME: Uncomment this line after set iconImage
//            utilitarianLargeTemplate.imageProvider = CLKImageProvider(onePieceImage: iconImage)
            utilitarianLargeTemplate.textProvider = CLKSimpleTextProvider(text: "\(cigarettesSmokedString) cigarros de \(dailyGoalString)")
            utilitarianLargeTemplate.textProvider.tintColor = mainColor
            
            template = utilitarianLargeTemplate
        default:
            break
        }
        
        if let templateFinal = template {
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate() as Date, complicationTemplate: templateFinal)
            handler(timelineEntry)
        } else {
            handler(nil)
        }
    }
    
    //MARK: - Placeholder templates
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate? = nil
        let textProvider = CLKSimpleTextProvider(text: self.cigarettesSmoked.description)
        let fill = Float(self.cigarettesSmoked)/Float(self.dailyGoal)
        
        switch complication.family {
        case .modularLarge:
            let modularLargeTemplate = CLKComplicationTemplateModularLargeStandardBody()
            //FIXME: Uncomment this line after set iconImage
//            modularLargeTemplate.headerImageProvider = CLKImageProvider(onePieceImage: iconImage)
            modularLargeTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Último Maço!")
            modularLargeTemplate.body1TextProvider = CLKSimpleTextProvider(text: "05 cigarros de 15")
            modularLargeTemplate.body2TextProvider = CLKSimpleTextProvider(text: "20 dias para parar!")
            
            modularLargeTemplate.headerTextProvider.tintColor = mainColor
            
            template = modularLargeTemplate
        case .modularSmall:
            let modularSmallTemplate = CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider = textProvider
            modularSmallTemplate.fillFraction = fill
            modularSmallTemplate.ringStyle = .closed
            
            modularSmallTemplate.tintColor = mainColor
            
            template = modularSmallTemplate
        case .circularSmall:
            let circularSmallTemplate = CLKComplicationTemplateCircularSmallRingText()
            circularSmallTemplate.textProvider = textProvider
            circularSmallTemplate.fillFraction = 0.7
            circularSmallTemplate.ringStyle = .open
            
            circularSmallTemplate.tintColor = mainColor
            
            template = circularSmallTemplate
        case .extraLarge:
            let extraLargeTemplate = CLKComplicationTemplateExtraLargeRingText()
            extraLargeTemplate.textProvider = textProvider
            extraLargeTemplate.fillFraction = fill
            extraLargeTemplate.ringStyle = .closed
            
            extraLargeTemplate.tintColor = mainColor
            
            template = extraLargeTemplate
        case .utilitarianSmall:
            let utilitarianSmallTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            utilitarianSmallTemplate.textProvider = textProvider
            utilitarianSmallTemplate.fillFraction = fill
            utilitarianSmallTemplate.ringStyle = .closed
            
            utilitarianSmallTemplate.tintColor = mainColor
            
            template = utilitarianSmallTemplate
        case .utilitarianLarge:
            let utilitarianLargeTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            //FIXME: Uncomment this line after set iconImage
            //            utilitarianLargeTemplate.imageProvider = CLKImageProvider(onePieceImage: iconImage)
            utilitarianLargeTemplate.textProvider = CLKSimpleTextProvider(text: "05 cigarros de 15")
            utilitarianLargeTemplate.textProvider.tintColor = mainColor
            
            template = utilitarianLargeTemplate
        default:
            break
        }
        handler(template)
    }
}
