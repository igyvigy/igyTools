
import Foundation

extension String {
  public var encoded: String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
  }
  
  public var html2Attributed: NSAttributedString? {
    do {
      guard let data = data(using: String.Encoding.utf8) else {
        return nil
      }
      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      print("error: ", error)
      return nil
    }
  }
  
  public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.height)
  }
  
  public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.width)
  }
  
  public var isEmail: Bool {
    let regex = try? NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")
    return (regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: count))) ?? 0 > 0
  }
  
  public var doesContainAtLeastOneDigit: Bool {
    let regex = try? NSRegularExpression(pattern: "^(?=.*\\d)")
    return (regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: count))) ?? 0 > 0
  }
  
  public var doesContainAtLeastOneSpecialCharacter: Bool {
    let regex = try? NSRegularExpression(pattern: "^(?=.*[@#$%^&+=])")
    return (regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: count))) ?? 0 > 0
  }
  
  public var doesContainAtLeastOneUpperCaseCharacter: Bool {
    let regex = try? NSRegularExpression(pattern: "^(?=.*[A-Z])")
    return (regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: count))) ?? 0 > 0
  }
  
  public var doesContainAtLeastOneLowerCaseCharacter: Bool {
    let regex = try? NSRegularExpression(pattern: "^(?=.*[a-z])")
    return (regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: count))) ?? 0 > 0
  }
  
  public func group(by groupSize:Int=3, separator:String="-") -> String {
    if count <= groupSize   { return self }
    let splitSize  = min(max(2, count - 1) , groupSize)
    let splitIndex = index(startIndex, offsetBy:splitSize)
    
    let sub = substring(to:splitIndex)
    let addition = substring(from:splitIndex).group(by:groupSize, separator:separator)
    let result = sub + separator + addition
    
    return result
  }
  
  public var withoutSpacesAndNewLines: String {
    return trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  public func index(from: Int) -> Index {
    return self.index(startIndex, offsetBy: from)
  }
  
  public func toUrl() -> URL? {
    return URL(string: self)
  }
}
