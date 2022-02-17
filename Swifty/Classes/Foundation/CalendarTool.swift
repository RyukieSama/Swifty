//
//  CalendarTool.swift
//  Ledger
//
//  Created by 王荣庆 on 2020/6/10.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import Foundation

/// 时间区间
public typealias SwiftyCalenderDateRange = (start: Date, end: Date)

public extension Calendar {
    /// 当前年
    public static let currentYear = Calendar.current.component(.year, from: Date())
    
    public static func year(of date: Date) -> Int {
        return Calendar.current.component(.year, from: date)
    }
    
    public static func weekDay(of date: Date) -> Int {
        return Calendar.current.component(.weekday, from: date)
    }
    
    public static func day(of date: Date) -> Int {
        return Calendar.current.component(.day, from: date)
    }
    
    public static func month(of date: Date) -> Int {
        return Calendar.current.component(.month, from: date)
    }
    
//    public static func weekDaysOf(date: Date = Date()) -> [Date] {
//        var start: Date?
//        var end: Date?
//
//        // 本周第一天 本周最后一天
//        let firstDateOfThisWeekComp = DateComponents(weekday: 1)
//        let finalDateOfThisWeekComp = DateComponents(weekday: 1)
//
//        start = Date().weekDay == 1 ? Date() : Calendar.current.nextDate(after: Date(), matching: firstDateOfThisWeekComp, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward)
//        end = Calendar.current.nextDate(after: Date(), matching: finalDateOfThisWeekComp, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .forward)
//
//        
//        return []
//    }
    
    /// 给出以当前时间位基准的时间区间
    /// - Parameter component: 维度
    /// - Parameter baseDate: 基准
    /// - Returns: 区间
    public static func currentRange(of component: Calendar.Component, baseDate: Date = Date()) -> SwiftyCalenderDateRange? {
        switch component {
        case .day:
            guard
                let star = Calendar.current.date(from: DateComponents(year: baseDate.year, month: baseDate.month, day: baseDate.day)),
                let end = Calendar.current.date(from: DateComponents(year: baseDate.year, month: baseDate.month, day: baseDate.day + 1))
                else {
                    return nil
            }
            return (star, end)
        case .month:
            guard
                let star = Calendar.current.date(from: DateComponents(year: baseDate.year, month: baseDate.month, day: 1)),
                let end = Calendar.current.date(from: DateComponents(year: baseDate.year, month: baseDate.month + 1, day: 1))
                else {
                    return nil
            }
            return (star, end)
        case .year:
            guard
                let star = Calendar.current.date(from: DateComponents(year: baseDate.year, month: 1, day: 1)),
                let end = Calendar.current.date(from: DateComponents(year: baseDate.year + 1, month: 1, day: 1))
                else {
                    return nil
            }
            return (star, end)
        default:
            return nil
        }
    }
    
}

public extension Date {
    var year: Int {
        return Calendar.year(of: self)
    }
    
    var weekDay: Int {
        return Calendar.weekDay(of: self)
    }
    
    var day: Int {
        return Calendar.day(of: self)
    }
    
    var month: Int {
        return Calendar.month(of: self)
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    public func sameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    public static func todayZero() -> Date {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let zero = Calendar.current.date(from: com)
        return zero ?? Date()
    }
    
    public static func tomorrow() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())
    }
    
    public func zero() -> Date {
        let com = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let zero = Calendar.current.date(from: com)
        return zero ?? Date()
    }
    
    public func nextDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    public func lastDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    
}
