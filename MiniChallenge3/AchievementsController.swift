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
    
    static public func generateAchievements(canObtainLastPackOfCigsAchievement: Bool) {
        instanceOfAchievement("threeDaysInARow.png")
        instanceOfAchievement("sevenDaysInARow.png")
        instanceOfAchievement("noSmokeForToday.png")
        instanceOfAchievement("remainedUnderGoal.png")
        instanceOfAchievement("halfCigarretes.png")
        instanceOfAchievement("reducedFirstCiggarret.png")
        if canObtainLastPackOfCigsAchievement { instanceOfAchievement("lastPackOfCigarretes.png") }
        instanceOfAchievement("stoppedSmoking.png")
        
    }
    
    static private var allEntries: [CigaretteEntry] = []
    
    static public func checkAllAchievements() -> [Achievement] {
        var won: [Achievement] = []
        
        do {
            if let all = (try DatabaseController.persistentContainer.viewContext.fetch(Achievement.fetchRequest()) as? [Achievement]) {
                
                do {
                    if var entries = (try DatabaseController.persistentContainer.viewContext.fetch(CigaretteEntry.fetchRequest()) as? [CigaretteEntry]) {
                        entries.sort(by: { ($0.date! as Date) < ($1.date! as Date) })
                        self.allEntries = entries
                        entries = entries.filter({ $0.cigaretteNumber != -1 && !Calendar.current.isDateInToday($0.date! as Date)})
                        won = all.filter({ check(achievement: $0, entries: entries) })
                    }
                } catch _ as NSError {
                    print("Error")
                }
            }
        } catch _ as NSError {
            print("Error")
        }
        DatabaseController.saveContext()
        return won
    }
    
    static private func check(achievement: Achievement, entries: [CigaretteEntry]) -> Bool {
        switch achievement.assetIdentifier! {
        case "threeDaysInARow.png":
            let allThreeDaysInARow = checkForThreeDaysInARow(entries)
            let r = allThreeDaysInARow - Int(achievement.amount)
            if r > 0 {
                achievement.amount = achievement.amount + Int16(r)
                achievement.hasAchievement = true
            }
            return r > 0
        case "sevenDaysInARow.png":
            let allThreeDaysInARow = checkForSevenDaysInARow(entries)
            let r = allThreeDaysInARow - Int(achievement.amount)
            if r > 0 {
                achievement.amount = achievement.amount + Int16(r)
                achievement.hasAchievement = true
            }
            return r > 0
        case "remainedUnderGoal.png":
            let numberOfUnderGoalEntries = entries.filter({ checkIfUnderGoal($0) }).count
            let r = numberOfUnderGoalEntries - Int(achievement.amount)
            if r > 0 {
                achievement.amount = achievement.amount + Int16(r)
                achievement.hasAchievement = true
            }
            return r > 0
        case "noSmokeForToday.png":
            let numberofnonsmokeddays = entries.filter({ $0.cigaretteNumber == 0 }).count
            let r = numberofnonsmokeddays - Int(achievement.amount)
            if r > 0 {
                achievement.amount = achievement.amount + Int16(r)
                achievement.hasAchievement = true
            }
            return r > 0
        case "halfCigarretes.png":
            if !achievement.hasAchievement {
                let anyEntryIsHalf = entries.filter({ $0.cigaretteNumber <= self.allEntries[0].cigaretteNumber / 2 }).count
                if anyEntryIsHalf > 0 {
                    achievement.hasAchievement = true
                    return true
                }
            }
            return false
        case "reducedFirstCiggarret.png":
            if !achievement.hasAchievement {
                let anyEntryIsLessThanTheFirst = entries.filter({ $0.cigaretteNumber < entries[0].cigaretteNumber - 1 }).count
                if anyEntryIsLessThanTheFirst > 0 {
                    achievement.hasAchievement = true
                    return true
                }
            }
            return false
        case "lastPackOfCigarretes.png":
            if !achievement.hasAchievement {
                let aheadEntries = self.allEntries.filter({ ($0.date as Date!) > Date() })
                let allAheadGoals = aheadEntries.map({ checkGoalCigarrets(entry: $0) })
                let sum = allAheadGoals.reduce(0, +)
                if sum <= 20 {
                    achievement.hasAchievement = true
                    return true
                }
            }
            return false
        case "stoppedSmoking.png":
            if !achievement.hasAchievement {
                let lastDay = self.allEntries.last
                if Calendar.current.isDateInToday(lastDay?.date as Date!) && lastDay?.cigaretteNumber == 0 {
                    achievement.hasAchievement = true
                    return true
                }
            }
            return false
        default:
            return false
        }
    }
    
    static public func checkGoalCigarrets(entry: CigaretteEntry) -> Int {
        let i = self.allEntries.index(of: entry)
        if i == self.allEntries.count - 1 { return 0 }
        return -(Int(Double(self.allEntries[0].cigaretteNumber)/Double(self.allEntries.count - 1) * Double(i!))) + Int(self.allEntries[0].cigaretteNumber)
    }
    
    static private func checkIfWasInGoal(_ entry: CigaretteEntry) -> Bool {
        return checkGoalCigarrets(entry: entry) >= Int(entry.cigaretteNumber)
    }
    
    static private func checkIfUnderGoal(_ entry: CigaretteEntry) -> Bool {
        return checkGoalCigarrets(entry: entry) > Int(entry.cigaretteNumber)
    }
    
    static private func checkForThreeDaysInARow(_ entries: [CigaretteEntry]) -> Int {
        var count = 0
        var i = 1
        while i < (entries.count - 3) {
            if (entries[i].date! as Date) > Date() {
                let e1 = entries[i]
                let e2 = entries[i + 1]
                let e3 = entries[i + 2]
                if checkIfWasInGoal(e1) && checkIfWasInGoal(e2) && checkIfWasInGoal(e3) {
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
        while i < (entries.count - 7) {
            if (entries[i].date! as Date) > Date() {
                let e1 = entries[i]
                let e2 = entries[i + 1]
                let e3 = entries[i + 2]
                let e4 = entries[i + 3]
                let e5 = entries[i + 4]
                let e6 = entries[i + 5]
                let e7 = entries[i + 6]
                if checkIfWasInGoal(e1) && checkIfWasInGoal(e2) && checkIfWasInGoal(e3) &&
                    checkIfWasInGoal(e4) && checkIfWasInGoal(e5) && checkIfWasInGoal(e6) &&
                    checkIfWasInGoal(e7) {
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
    
}
