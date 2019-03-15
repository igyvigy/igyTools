
import UIKit

public enum DateFormatterType: String {
  case `default` = "yyyy-MM-dd HH:mm:ss ZZZZZ",
  hourMinute = "HH:mm",
  ddMMyyyy = "dd/MM/yyyy",
  weekDayMonthDayHHmm = "EEE MMM d, HH:mm",
  monthDayHHMM = "MMM d, HH:mm",
  monthDd = "MMMM dd"
}

public final class DateFormatterHelper {
  fileprivate static let formatter = DateFormatter()
  fileprivate static let weekDayFormatter: DateFormatter = {
    var form = DateFormatter()
    form.locale = Locale(identifier: "en_US")
    form.dateFormat = "EEEE"
    
    return form
  }()
  
  public static func date(from string: String, with type: DateFormatterType = .default) -> Date? {
    objc_sync_enter(self)
    defer { objc_sync_exit(self) }
    
    formatter.dateFormat = type.rawValue
    
    return formatter.date(from: string)
  }
  
  public static func getWeekDay(from date: Date) -> String {
    return weekDayFormatter.string(from: date)
  }
  
  public static func string(from date: Date, with type: DateFormatterType = .default) -> String {
    objc_sync_enter(self)
    defer { objc_sync_exit(self) }
    
    formatter.dateFormat = type.rawValue
    
    return formatter.string(from: date)
  }
  
  // MARK: - Custom
  
  public static func getCurrentDayTimeInterval(from hhmm: String, isOverlaped: Bool) -> TimeInterval {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
    let hour = hhmm[..<hhmm.index(from: 2)]
    let minute = hhmm[hhmm.index(from: 3)...]
    components.day = (components.day ?? 0) + (isOverlaped ? 1 : 0)
    components.hour = Int(hour) ?? 0
    components.minute = Int(minute) ?? 0
    
    return Calendar.current.date(from: components)?.timeIntervalSince1970 ?? 0
  }
  
}
