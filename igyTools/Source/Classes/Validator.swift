import Foundation

public class Validate {
  
  public enum Validation {
    case email, notEmpty, length(_ l: Int), numbers
    
    var error: String? {
      switch self {
      case .email: return "not valid email"
      case .notEmpty: return "can't be empty"
      case .length(let l): return "can't have more than \(l) chars"
      case .numbers: return "can only contain numbers"
      }
    }
    
    func isValid(_ s: String?) -> Bool {
      switch self {
      case .email:
        if s?.isEmpty == true { return true }
        return s?.isEmail == true
      case .notEmpty: return s?.isEmpty == false
      case .length(let l):
        if s?.isEmpty == true { return true }
        return (s?.count).orZero <= l
      case .numbers:
        if s?.isEmpty == true { return true }
        return Validate.match(regex: "^\\d+$", text: s.orEmpty).count > 0
      }
    }

  }
  
  static func match(regex: String, text: String) -> [String] {
    do {
      let regex = try NSRegularExpression(pattern: regex)
      let results = regex.matches(in: text,
                                  range: NSRange(text.startIndex..., in: text))
      return results.map {
        String(text[Range($0.range, in: text)!])
      }
    } catch let error {
      print("invalid regex: \(error.localizedDescription)")
      return []
    }
  }
  
  public static func string(_ s: String?, validations: [Validation]) -> [String?] {
    return validations.map { $0.isValid(s) ? nil : $0.error }
  }
}
