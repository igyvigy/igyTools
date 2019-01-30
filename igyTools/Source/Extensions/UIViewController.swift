
import UIKit

extension UIViewController {
  public func showSpinner(shouldBlockUI: Bool) {
    let spinnerView = UIView(frame: .zero)
    spinnerView.backgroundColor = .black
    spinnerView.alpha = 0.4
    spinnerView.roundCorner(radius: 8)
    spinnerView.tag = "spinner_view_tag".hashValue
    
    view.addSubview(spinnerView, with: ConstraintsSettings(centerX: 0, centerY: 0, width: 100, height: 100))
    
    let spinner = ActivityIndicator(frame: .zero)
    spinner.animationDuration = 3
    spinner.rotationDuration = 3
    spinner.numSegments = 12
    spinner.strokeColor = .white
    spinner.lineWidth = 2
    spinner.tag = "spinner_tag".hashValue
    
    view.addSubview(spinner, with: ConstraintsSettings(centerX: 0, centerY: 0, width: 60, height: 60))
    
    spinnerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    spinnerView.alpha = 0
    spinner.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    spinner.alpha = 0
    
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, animations: {
      spinnerView.transform = CGAffineTransform.identity
      spinnerView.alpha = 0.4
      spinner.transform = CGAffineTransform.identity
      spinner.alpha = 1
    }) { success in
      spinner.startAnimating()
    }
    
    if shouldBlockUI { view.isUserInteractionEnabled = false }
  }
  
  public func hideSpinner() {
    self.view.subviews.filter({ $0.tag == "spinner_view_tag".hashValue }).forEach { spinnerView in
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
        spinnerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        spinnerView.alpha = 0
      }) { success in
        spinnerView.removeFromSuperview()
      }
      if !self.view.isUserInteractionEnabled { self.view.isUserInteractionEnabled = true }
    }
    self.view.subviews.filter({ $0.tag == "spinner_tag".hashValue }).forEach { spinner in
      guard let spinner = spinner as? ActivityIndicator else { return }
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
        spinner.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        spinner.alpha = 0
      }) { success in
        spinner.removeFromSuperview()
      }
      spinner.stopAnimating()
      if !self.view.isUserInteractionEnabled { self.view.isUserInteractionEnabled = true }
    }
  }
  
  public var className: String {
    var className = String(describing: type(of: self))
    className.firstIndex(of: "<").map {
      className = String(className[className.startIndex..<$0])
    }
    return className
  }
  
  private struct AssociatedKeys {
    static var resultHandler = "resultHandler"
  }
  
  public var resultHandler: ((AnyObject?) -> Void)? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.resultHandler) as? ((AnyObject?) -> Void)
    }
    set { objc_setAssociatedObject(self, &AssociatedKeys.resultHandler, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
  
  public func present(_ vc: UIViewController, forResult result: @escaping (AnyObject?) -> Void, completion: (() -> Void)? = nil) {
    if let vc = (vc as? UINavigationController)?.viewControllers.first {
      vc.resultHandler = result
    } else {
      vc.resultHandler = result
    }
    present(vc, animated: true, completion: completion)
  }
  
  public func push(_ vc: UIViewController, forResult result: @escaping (AnyObject?) -> Void) {
    vc.resultHandler = result
    navigationController?.pushViewController(vc, animated: true)
  }
}
