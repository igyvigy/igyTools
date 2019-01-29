
import Foundation

public func arrayDiff<T1, T2>(_ first: [T1], _ second: [T2], with compare: (T1, T2) -> Bool) -> ArryDiff<T1, T2> {
  let combinations = first.compactMap { firstElement in (firstElement, second.first { secondElement in compare(firstElement, secondElement) }) }
  let common = combinations.filter { $0.1 != nil }.map { ($0.0, $0.1!) }
  let removed = combinations.filter { $0.1 == nil }.map { ($0.0) }
  let inserted = second.filter { secondElement in !common.contains { compare($0.0, secondElement) } }
  
  return ArryDiff(common: common, removed: removed, inserted: inserted)
}

public struct ArryDiff<T1, T2> {
  public let common: [(T1, T2)]
  public let removed: [T1]
  public let inserted: [T2]
  public init(common: [(T1, T2)] = [], removed: [T1] = [], inserted: [T2] = []) {
    self.common = common
    self.removed = removed
    self.inserted = inserted
  }
}