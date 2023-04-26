//
//  Date + Extenstions.swift
//  MultiSport
//
//  Created by Витя Рябко on 26/04/23.
//

import Foundation


extension Date {
    func getNumberOfDayOfWeek() -> Int {
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: self)
        return weekDay
    }
    
    func offsetMonth(month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: self) ?? Date()
    }
}
