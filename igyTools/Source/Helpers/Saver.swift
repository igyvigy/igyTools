
import Foundation

final public class Saver {
  static public func getBool(for key: String) -> Bool {
    return UserDefaults.standard.bool(forKey: key)
  }
  
  static public func saveBool(_ value: Bool?, for key: String) {
    UserDefaults.standard.set(value, forKey: key)
  }
  
  static public func getString(for key: String) -> String? {
    return UserDefaults.standard.string(forKey: key)
  }
  
  static public func saveString(_ value: String?, for key: String) {
    UserDefaults.standard.set(value, forKey: key)
  }
}
