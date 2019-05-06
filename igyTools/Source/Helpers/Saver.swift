
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
  
  static public func getArray(_ arrayName: String) -> [String]? {
    return UserDefaults.standard.stringArray(forKey: arrayName)
  }
  
  static public func insertToArrayIfNotContained(_ arrayName: String, item: String) {
    if var array = getArray(arrayName) {
      if !array.contains(item) {
        array.append(item)
        UserDefaults.standard.set(array, forKey: arrayName)
      }
    } else {
      var new = [String]()
      new.append(item)
      UserDefaults.standard.set(new, forKey: arrayName)
    }
  }
  
  static public func removeFromArrayIfContained(_ arrayName: String, item: String) {
    guard var array = getArray(arrayName) else { return }
    if array.contains(item) {
      array.remove(item)
      UserDefaults.standard.set(array, forKey: arrayName)
    }
  }
  
}
