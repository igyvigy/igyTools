
import Foundation

extension Float {
  public var danishCurrencyString: String {
    var withDecimal = String(NSString(format: "%.2f", self))
    if self < 0 { withDecimal = withDecimal.replacingOccurrences(of: "-", with: "") }
    let naturalNumbers = String(withDecimal.split(separator: ".")[0])
    let decimalNumbers = String(withDecimal.split(separator: ".")[1])
    let grouped = String(naturalNumbers.reversed()).group(by: 3, separator: ".")
    return self < 0 ? "-" + grouped.reversed() + "," + decimalNumbers + " DKK" : grouped.reversed() + "," + decimalNumbers + " DKK"
  }

}

