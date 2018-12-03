//
//  Date.swift
//  Rolique
//
//  Created by Andrii Narinian on 8/15/17.
//  Copyright © 2017 Rolique. All rights reserved.
//

import UIKit

extension Date {
  public var mondayOfWeek: Date {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
    components.weekday = 2
    return calendar.date(from: components)!
  }
  
  public var normalized: Date {
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.day, .month, .year], from: self)
    let date = calendar.date(from: components)!
    
    return date
  }
  
  public var withoutSeconds: Date {
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: self)
    let date = calendar.date(from: components)!
    
    return date
  }
  
  public var onlyTime: Date {
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.minute, .hour], from: self)
    let date = calendar.date(from: components)!
    
    return date
  }
  
  public var sundayOfWeek: Date {
    let calendar = Calendar.current
    
    var components = calendar.dateComponents([.day, .month, .year], from: mondayOfWeek)
    components.day = (components.day ?? 0) + 6
    let date = calendar.date(from: components)!
    
    return date
  }
  
  public var weekFriday: Date {
    let calendar = Calendar.current
    
    var components = calendar.dateComponents([.day, .month, .year], from: mondayOfWeek)
    components.day = (components.day ?? 0) + 4
    let date = Calendar.current.date(from: components)!
    
    return date
  }
  
  public var startOfDay: Date {
    let calendar = Calendar.current
    
    return calendar.date(from: calendar.dateComponents([.year, .month, .day], from: self))!
  }
  
  public static func getDates(from range: ClosedRange<Date>, with step: Int = 1) -> [Date] {
    let calendar = Calendar.current
    var dates = [range.lowerBound.normalized]
    let units = Set<Calendar.Component>([.day, .month, .year])
    let components = calendar.dateComponents(units, from: range.lowerBound)
    var acc = step
    
    while true {
      var tmpComponents = components
      tmpComponents.day = (components.day ?? 0) + acc
      let date = calendar.date(from: tmpComponents)!.normalized
      
      if date < range.upperBound.normalized {
        dates.append(date)
      } else {
        dates.append(range.upperBound.normalized)
        break
      }
      
      acc += step
    }
    
    return dates
  }
  
  public var startOfMonth: Date {
    let calendar = Calendar.current
    let units = Set<Calendar.Component>([.month, .year])
    let dateComponents = calendar.dateComponents(units, from: self)
    
    return calendar.date(from: dateComponents)!
  }
  
  public var endOfMonth: Date {
    let calendar = Calendar.current
    let units = Set<Calendar.Component>([.day, .month, .year])
    var dateComponents = calendar.dateComponents(units, from: self)
    dateComponents.month = (dateComponents.month ?? 0) + 1
    dateComponents.day = 0
    
    return calendar.date(from: dateComponents)!
  }
  
  @available(iOS 10.0, *)
  public var daysInCurrentMonth: Int {
    let calendar = Calendar.current
    let interval = calendar.dateInterval(of: .month, for: self)!
    let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
    
    return days
  }
  
  public var hours: Int {
    let calendar = Calendar.current
    let units = Set<Calendar.Component>([.hour])
    let dateComponents = calendar.dateComponents(units, from: self)
    return dateComponents.hour ?? 0
  }
  
  public var minutes: Int {
    let calendar = Calendar.current
    let units = Set<Calendar.Component>([.minute])
    let dateComponents = calendar.dateComponents(units, from: self)
    return dateComponents.minute ?? 0
  }
  
  public var isSunday: Bool {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.weekday], from: self)
    return components.weekday == 7
  }
  
  public var isSaturday: Bool {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.weekday], from: self)
    
    return components.weekday == 6
  }
  
  public var nextDay: Date {
    return Date(timeInterval: 60 * 60 * 24, since: self)
  }
  
  public static func calculateWorkDaysInMonth(for date: Date, to barrier: Date? = nil) -> Int {
    let start = date.startOfMonth
    let end = date.endOfMonth
    var dates = Date.getDates(from: start...end).filter { !$0.isSunday && !$0.isSaturday }
    dates = barrier == nil ? dates : dates.filter { $0 <= barrier! }
    
    return dates.count
  }
  
  public func toStringVithRelativeValue() -> String {
    let now = Date().normalized
    
    let diff = Calendar.current.compare(now, to: self, toGranularity: Calendar.Component.day)
    switch diff {
    case .orderedSame:
      return "today".localized
    case .orderedAscending:
      return "tomorrow".localized
    case .orderedDescending:
      return "yesterday".localized
    }
  }
}
