//
//  Date + MonthStartEnd.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 05.01.2023.
//

import Foundation

extension Date {
    
    func startOfTheMont(backForThisMany months: Int) -> Date? {
        let previousMonth = Calendar.current.date(byAdding: .month, value: -months, to: Date())
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: previousMonth!) as NSDateComponents
        components.day = 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    func endOfOneMonthBack(backForThisMany months: Int) -> Date? {
        let previousMonth = Calendar.current.date(byAdding: .month, value: -months, to: Date())
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: previousMonth!) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
}
