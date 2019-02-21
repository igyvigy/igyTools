import Foundation

public class Validate {
  
  public enum Validation {
    case email, notEmpty, length(_ l: Int)
    
    var error: String? {
      switch self {
      case .email: return "not valid email"
      case .notEmpty: return "can't be empty"
      case .length(let l): return "can't have more than \(l) chars"
      }
    }
    
    func isValid(_ s: String?) -> Bool {
      switch self {
      case .email: return s?.isEmail == true
      case .notEmpty: return s?.isEmpty == false
      case .length(let l): return (s?.count).orZero <= l
      }
    }
  }
  
  public static func string(_ s: String?, validations: [Validation]) -> [String?] {
    return validations.map { $0.isValid(s) ? nil : $0.error }
  }
}
