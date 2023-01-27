//
//  DatesManager.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 05.01.2023.
//

import Foundation

class DatesManager {
    let dateFormatter = DateFormatter()
    
    func getTodaysDate() -> String {
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    func getRandomDay() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = dateFormatter.date(from: "1995-06-16")
        let today = dateFormatter.string(from: Date())
        let date2 = dateFormatter.date(from: today)
        let span = TimeInterval.random(in: date1!.timeIntervalSinceNow...date2!.timeIntervalSinceNow)
        return dateFormatter.string(from: Date(timeIntervalSinceNow: span))
    }
    
    func getLastThreeWeeks(forDate date: Date) -> [String] {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let threeWeeksAgo = Calendar.current.date(byAdding: .day, value: -20, to: date)
        return [dateFormatter.string(from: threeWeeksAgo!), dateFormatter.string(from: date)]
    }
    
    func getLastThreeMonths() -> [[String]] {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startOf3MonthsBack = dateFormatter.string(for: Date().startOfTheMont(backForThisMany: 3))!
        let endOf3MonthsBack = dateFormatter.string(for: Date().endOfOneMonthBack(backForThisMany: 3))!
        let startOf2MonthsBack = dateFormatter.string(for: Date().startOfTheMont(backForThisMany: 2))!
        let endOf2MonthsBack = dateFormatter.string(for: Date().endOfOneMonthBack(backForThisMany: 2))!
        let startOf1MonthsBack = dateFormatter.string(for: Date().startOfTheMont(backForThisMany: 1))!
        let endOf1MonthsBack = dateFormatter.string(for: Date().endOfOneMonthBack(backForThisMany: 1))!
        return [[startOf1MonthsBack, endOf1MonthsBack], [startOf2MonthsBack, endOf2MonthsBack], [startOf3MonthsBack, endOf3MonthsBack]]
    }
    
    func shortenDateToMonth(dateString: String) -> String {
        var newDateString = ""
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMMM, yyyy"
            newDateString = dateFormatter.string(from: date)
        }
        return newDateString
    }
}

