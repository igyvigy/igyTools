
import Foundation

extension String {
  public var encoded: String? {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
  }
}
