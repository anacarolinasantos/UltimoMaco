//
//  AchievementsController.swift
//  MiniChallenge3
//
//  Created by Guilherme Paciulli on 14/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications

public class AchievementsController {
    
    static private func instanceOfAchievement(_ id: String) {
        let a = NSEntityDescription.insertNewObject(forEntityName: "Achievement", into: DatabaseController.persistentContainer.viewContext) as! Achievement
        a.assetIdentifier = id
        a.amount = 0
        a.hasAchievement = false
    }
    
    static public func generateAchievements() {
        instanceOfAchievement("threeDaysInARow.png")
        instanceOfAchievement("sevenDaysInARow.png")
        instanceOfAchievement("noSmokeForToday.png")
        instanceOfAchievement("remainedUnderGoal.png")
        instanceOfAchievement("halfCigarretes.png")
        instanceOfAchievement("reducedFirstCiggarret.png")
        instanceOfAchievement("lastPackOfCigarretes.png")
        instanceOfAchievement("stoppedSmoking.png")

    }
    
    static public func checkAllAchievements() -> [Achievement] {
        var won: [Achievement] = []
        do {
            if let all = (try DatabaseController.persistentContainer.viewContext.fetch(Achievement.fetchRequest()) as? [Achievement]) {
                won = all.filter({ checkAchievement($0) })
            }
        } catch _ as NSError {
            print("Error")
        }
        
        return won
    }
    
    static private func checkAchievement(_ a: Achievement) -> Bool {
        do {
            
            if var entries = (try DatabaseController.persistentContainer.viewContext.fetch(CigaretteEntry.fetchRequest()) as? [CigaretteEntry]) {
                
                entries = entries.sorted(by: { ($0.date! as Date) < ($1.date! as Date) })
                
                switch a.assetIdentifier! {
                case "threeDaysInARow.png":
                    let allThreeDaysInARow = checkForThreeDaysInARow(entries)
                    let r = allThreeDaysInARow - Int(a.amount)
                    if r > 0 {
                        a.amount = a.amount + Int16(r)
                        a.hasAchievement = true
                    }
                    return r > 0
                case "sevenDaysInARow.png":
                    let allThreeDaysInARow = checkForSevenDaysInARow(entries)
                    let r = allThreeDaysInARow - Int(a.amount)
                    if r > 0 {
                        a.amount = a.amount + Int16(r)
                        a.hasAchievement = true
                    }
                    return r > 0
                case "remainedUnderGoal.png":
                    let numberOfUnderGoalEntries = entries.filter({ checkIfUnderGoal($0, entries) }).count
                    let r = numberOfUnderGoalEntries - Int(a.amount)
                    if r > 0 {
                        a.amount = a.amount + Int16(r)
                        a.hasAchievement = true
                    }
                    return r > 0
                case "noSmokeForToday.png":
                    let numberofnonsmokeddays = entries.filter({ $0.cigaretteNumber == 0 }).count
                    let r = numberofnonsmokeddays - Int(a.amount)
                    if r > 0 {
                        a.amount = a.amount + Int16(r)
                        a.hasAchievement = true
                    }
                    return r > 0
                case "halfCigarretes.png":
                    if !a.hasAchievement {
                        let anyEntryIsHalf = entries.filter({ $0.cigaretteNumber == entries[0].cigaretteNumber / 2 }).count
                        if anyEntryIsHalf > 0 {
                            a.hasAchievement = true
                            return true
                        }
                    }
                    return false
                case "reducedFirstCiggarret.png":
                    if !a.hasAchievement {
                        let anyEntryIsHalf = entries.filter({ $0.cigaretteNumber != -1 && $0.cigaretteNumber < entries[0].cigaretteNumber - 1 }).count
                        if anyEntryIsHalf > 0 {
                            a.hasAchievement = true
                            return true
                        }
                    }
                    return false
                case "lastPackOfCigarretes.png":
                    if !a.hasAchievement {
                        let aheadEntries = entries.filter({ ($0.date as Date!) > Date() })
                        var sum = 0
                        for e in aheadEntries {
                            sum += checkGoalCigarrets(entry: e, allEntries: entries)
                        }
                        if sum <= 20 {
                            a.hasAchievement = true
                            return true
                        }
                    }
                    return false
                case "stoppedSmoking.png":
                    if !a.hasAchievement {
                        let lastDay = entries.last
                        if Calendar.current.isDateInToday(lastDay?.date as Date!) && lastDay?.cigaretteNumber == 0 {
                            a.hasAchievement = true
                            return true
                        }
                    }
                    return false
                default:
                    return false
                }
            }
        } catch _ as NSError {
            print("Error")
        }
        return false
    }
    
    static public func checkGoalCigarrets(entry: CigaretteEntry, allEntries: [CigaretteEntry]) -> Int {
        let i = allEntries.index(of: entry)
        if i == allEntries.count - 1 { return 0 }
        return -(Int(Double(allEntries[0].cigaretteNumber)/Double(allEntries.count - 1) * Double(i!))) + Int(allEntries[0].cigaretteNumber)
    }
    
    static private func checkIfWasInGoal(_ entry: CigaretteEntry, _ allEntries: [CigaretteEntry]) -> Bool {
        return checkGoalCigarrets(entry: entry, allEntries: allEntries) <= Int(entry.cigaretteNumber)
    }
    
    static private func checkIfUnderGoal(_ entry: CigaretteEntry, _ allEntries: [CigaretteEntry]) -> Bool {
        return checkGoalCigarrets(entry: entry, allEntries: allEntries) < Int(entry.cigaretteNumber)
    }
    
    static private func checkForThreeDaysInARow(_ entries: [CigaretteEntry]) -> Int {
        var count = 0
        var i = 1
        while i < (entries.count - 3) {
            if (entries[i].date! as Date) > Date() {
                let e1 = entries[i]
                let e2 = entries[i + 1]
                let e3 = entries[i + 2]
                if checkIfWasInGoal(e1, entries) && checkIfWasInGoal(e2, entries) && checkIfWasInGoal(e3, entries) {
                    i += 3
                    count += 1
                } else {
                    i += 1
                }
            } else {
                break
            }
        }
        return count
    }
    
    static private func checkForSevenDaysInARow(_ entries: [CigaretteEntry]) -> Int {
        var count = 0
        var i = 1
        while i < (entries.count - 3) {
            if (entries[i].date! as Date) > Date() {
                let e1 = entries[i]
                let e2 = entries[i + 1]
                let e3 = entries[i + 2]
                let e4 = entries[i + 3]
                let e5 = entries[i + 4]
                let e6 = entries[i + 5]
                let e7 = entries[i + 6]
                if checkIfWasInGoal(e1, entries) && checkIfWasInGoal(e2, entries) && checkIfWasInGoal(e3, entries) &&
                   checkIfWasInGoal(e4, entries) && checkIfWasInGoal(e5, entries) && checkIfWasInGoal(e6, entries) &&
                   checkIfWasInGoal(e7, entries) {
                    i += 7
                    count += 1
                } else {
                    i += 1
                }
            } else {
                break
            }
        }
        return count
    }
    
    static public func test() {
        for i in 0...(4 * 7) {
            let cigEntry = NSEntityDescription.insertNewObject(forEntityName: "CigaretteEntry", into: DatabaseController.persistentContainer.viewContext) as! CigaretteEntry
            cigEntry.date = Calendar.current.date(byAdding: .day, value: i - 1, to: Date())! as NSDate
            if i == 1 {
                cigEntry.cigaretteNumber = Int32(30)
            } else {
                cigEntry.cigaretteNumber = -1
            }
        }
        DatabaseController.saveContext()
        AchievementsController.generateAchievements()
        DatabaseController.saveContext()
        do {
            if var entries = try(DatabaseController.persistentContainer.viewContext.fetch(CigaretteEntry.fetchRequest()) as? [CigaretteEntry]) {
                entries = entries.sorted(by: { ($0.date! as Date) < ($1.date! as Date) })
                for e in entries {
                    let i = checkGoalCigarrets(entry: e, allEntries: entries)
                    if entries.index(of: e) != 0 {
                        e.cigaretteNumber = Int32(i)
                    }
                    print(i)
                }
                _ = checkAllAchievements()
            }
        } catch _ as NSError {
            print("Error")
        }
    }

}
