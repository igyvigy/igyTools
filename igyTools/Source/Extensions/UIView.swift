
import UIKit

extension UIView {
  public func addBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat = 0) {
    layer.addBorder(width: width, color: color, cornerRadius: cornerRadius)
  }
  
  public func roundCorner(radius: CGFloat) {
    layer.roundCorner(radius: radius)
  }
  
  public func animateCornerRadius(to value: CGFloat, with interval: TimeInterval) {
    layer.animateCornerRadius(to: value, with: interval)
  }
  
  public func toCirle() {
    layer.roundCorner(radius: bounds.height / 2)
  }
  
  public func createAndConfigureSubview(_ view: UIView?) {
    guard let view = view else { return }
    
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.translatesAutoresizingMaskIntoConstraints = true
    view.frame = frame
    addSubview(view)
  }
  
  public func roundCorners(_ corners: UIRectCorner, radius: CGSize) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radius)
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  public func getSubviewsOf<T: UIView>(view: UIView) -> [T] {
    var subviews = [T]()
    
    for subview in view.subviews {
      subviews += getSubviewsOf(view: subview) as [T]
      
      if let subview = subview as? T {
        subviews.append(subview)
      }
    }
    
    return subviews
  }
  
  public func showSpinner() {
    let spinnerView = UIView(frame: .zero)
    spinnerView.backgroundColor = .black
    spinnerView.alpha = 0.4
    spinnerView.roundCorner(radius: 8)
    spinnerView.tag = "spinner_view_tag".hashValue
    
    addSubview(spinnerView, with: ConstraintsSettings(centerX: 0, centerY: 0, width: 100, height: 100))
    
    let spinner = ActivityIndicator(frame: .zero)
    spinner.animationDuration = 3
    spinner.rotationDuration = 3
    spinner.numSegments = 12
    spinner.strokeColor = .white
    spinner.lineWidth = 2
    spinner.tag = "spinner_tag".hashValue
    
    addSubview(spinner, with: ConstraintsSettings(centerX: 0, centerY: 0, width: 60, height: 60))
    
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

  }
  
  public func hideSpinner() {
    let spinnerView = subviews.filter({ $0.tag == "spinner_view_tag".hashValue }).first
    let spinner = subviews.filter({ $0.tag == "spinner_tag".hashValue }).first as? ActivityIndicator
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
      spinnerView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      spinner?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      spinnerView?.alpha = 0
      spinner?.alpha = 0
    }) { success in
      spinnerView?.removeFromSuperview()
      spinner?.removeFromSuperview()
    }
    spinner?.stopAnimating()
  }
  
  public func addGradient(with colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.5, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1)) {
    let gradeintLayer = CAGradientLayer()
    gradeintLayer.colors = colors.map { $0.cgColor }
    gradeintLayer.startPoint = startPoint
    gradeintLayer.endPoint = endPoint
    
    layer.insertSublayer(gradeintLayer, at: 0)
  }
}

@IBDesignable
open class NibLoadingView: UIView {
  
  @IBOutlet public weak var view: UIView!
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    nibSetup()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    nibSetup()
  }
  
  private func nibSetup() {
    backgroundColor = .clear
    
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.translatesAutoresizingMaskIntoConstraints = true
    
    addSubview(view)
  }
  
  private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return nibView
  }
}
