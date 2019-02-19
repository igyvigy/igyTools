import Foundation

public class Validate {
  
  public enum Validation {
    case email, notEmpty
    
    var error: String? {
      switch self {
      case .email: return "not valid email"
      case .notEmpty: return "can't be empty"
      }
    }
    
    func isValid(_ s: String?) -> Bool {
      switch self {
      case .email: return s?.isEmail == true
      case .notEmpty: return s?.isEmpty == false
      }
    }
  }
  
  public static func string(_ s: String?, validations: [Validation]) -> [String?] {
    return validations.map { $0.isValid(s) ? nil : $0.error }
  }
}
