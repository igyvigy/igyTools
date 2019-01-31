
import UIKit

extension UITableView {
  public func setDelegateAndDataSource(_ object: UITableViewDelegate & UITableViewDataSource) {
    self.delegate = object
    self.dataSource = object
  }
  
  public func scrollToBottom(animated: Bool = true) {
    let section = numberOfSections - 1
    let row = numberOfRows(inSection: section) - 1
    
    guard section >= 0, row >= 0 else {
      return
    }
    
    let indexPath = IndexPath(row: row, section: section)
    scrollToRow(at: indexPath, at: .bottom, animated: animated)
  }
  
  public func register(_ cells: [UITableViewCell.Type]) {
    cells.forEach({
      let cellName = String(describing: $0)
      let nib = UINib(nibName: cellName, bundle: nil)
      register(nib, forCellReuseIdentifier: cellName)
    })
  }
  
  public static func averageOf(_ numbers: [Int]) -> CGFloat {
    if numbers.count == 0 {
      return 0
    }
    var sum = 0
    for number in numbers {
      sum += number
    }
    return CGFloat(sum / numbers.count)
  }
  
  @discardableResult public func getContentOffset(for offsetPercentage: CGFloat, topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
    var contentHeight: CGFloat {
      return contentSize.height
    }
    var innerFrameHeight: CGFloat {
      return frame.height - topInset - bottomInset
    }
    var maxOffset: CGFloat {
      return contentHeight - innerFrameHeight
    }
    var offset: CGFloat {
      return offsetPercentage / 100 * maxOffset
    }
    var checkSum: CGFloat {
      return contentHeight - (offset + innerFrameHeight)
    }
    var contentOffset: CGFloat {
      return offset - topInset
    }
    
    return contentOffset
  }
  
  @discardableResult public func getOffsetPercentage(topInset: CGFloat, bottomInset: CGFloat) -> CGFloat {
    var offset: CGFloat {
      return contentOffset.y + topInset
    }
    var contentHeight: CGFloat {
      return contentSize.height
    }
    var innerFrameHeight: CGFloat {
      return frame.height - topInset - bottomInset
    }
    var checkSum: CGFloat {
      return contentHeight - (offset + innerFrameHeight)
    }
    var maxOffset: CGFloat {
      return contentHeight - innerFrameHeight
    }
    var offsetPercentage: CGFloat {
      return offset/maxOffset * 100.0
    }
    
    return offsetPercentage
  }
  
  public var capturedImage : UIImage {
    UIGraphicsBeginImageContextWithOptions(contentSize, false, 0.0)
    let savedContentOffset = contentOffset
    let savedFrame = frame
    contentOffset = .zero
    frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    contentOffset = savedContentOffset
    frame = savedFrame
    UIGraphicsEndImageContext()
    
    return image!
  }
  
  public func reloadInteractively<A: Hashable, B: Hashable>(oldItems: [A], newItems: [B], compare: (A, B) -> Bool, section: Int = 0) {
    let diff = arrayDiff(oldItems, newItems, with: compare)
    if !diff.removed.isEmpty {
      deleteRows(at: diff.removed.map { IndexPath(item: oldItems.index(of: $0)!, section: section) }, with: UITableView.RowAnimation.automatic)
    }
    if !diff.inserted.isEmpty {
      insertRows(at: diff.inserted.map { IndexPath(item: newItems.index(of: $0)!, section: section) }, with: UITableView.RowAnimation.automatic)
    }
    if !diff.common.isEmpty {
      reloadRows(at: diff.common.map { IndexPath(item: newItems.index(of: $0.1)!, section: section) }, with: UITableView.RowAnimation.automatic)
    }
  }
  
  public func reloadInteractively<A: Hashable, B: Hashable>(changes: ArryChanges<A, B>, section: Int) {
    if !changes.diff.removed.isEmpty {
      deleteRows(at: changes.diff.removed.map { IndexPath(item: changes.first.index(of: $0)!, section: section) }, with: UITableView.RowAnimation.automatic)
    }
    if !changes.diff.inserted.isEmpty {
      insertRows(at: changes.diff.inserted.map { IndexPath(item: changes.second.index(of: $0)!, section: section) }, with: UITableView.RowAnimation.automatic)
    }
    if !changes.diff.common.isEmpty {
      reloadRows(at: changes.diff.common.map { IndexPath(item: changes.second.index(of: $0.1)!, section: section) }, with: UITableView.RowAnimation.automatic)
    }
  }
}
