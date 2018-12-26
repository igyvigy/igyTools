//
//  TimeInterval.swift
//  Alamofire
//
//  Created by Bohdan Savych on 12/17/18.
//

import Foundation

public extension TimeInterval {
  public static var minute: TimeInterval {
    return 60
  }
  
  public static var hour: TimeInterval {
    return minute * 60
  }
  
  public static var day: TimeInterval {
    return hour * 24
  }
  
  public static var week: TimeInterval {
    return day * 7
  }
  
  public static var notLeapYear: TimeInterval {
    return day * 365
  }
  
  public static var leapYear: TimeInterval {
    return day * 366
  }
}
