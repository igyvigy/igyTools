
import UIKit

//GRADIENT VIEW
internal class GradientViewConfig: NSObject {
  var color1: UIColor = .clear
  var color2: UIColor = .clear
  var startPoint: CGPoint = .zero
  var endPoint: CGPoint = .zero
  var locations: [NSNumber]?
}

public class GradientView: UIView {
  override public class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
}

extension GradientView {
  private struct AssociatedKeys {
    static var gradientConfig = "gradientConfig"
  }
  
  internal var gradientConfig: GradientViewConfig {
    get {
      if let config = objc_getAssociatedObject(self, &AssociatedKeys.gradientConfig) as? GradientViewConfig {
        return config
      }
      let config = GradientViewConfig()
      self.gradientConfig = config
      return config
    }
    set { objc_setAssociatedObject(self, &AssociatedKeys.gradientConfig, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
  
  @IBInspectable public var grColor1: UIColor {
    get { return gradientConfig.color1 }
    set {
      gradientConfig.color1 = newValue
      apply()
    }
  }
  
  @IBInspectable public var grColor2: UIColor {
    get { return gradientConfig.color2 }
    set {
      gradientConfig.color2 = newValue
      apply()
    }
  }
  
  @IBInspectable public var startPoint: CGPoint {
    get { return gradientConfig.startPoint }
    set {
      gradientConfig.startPoint = newValue
      apply()
    }
  }
  
  @IBInspectable public var endPoint: CGPoint {
    get { return gradientConfig.endPoint }
    set {
      gradientConfig.endPoint = newValue
      apply()
    }
  }
  public var locations: [NSNumber]? {
    get { return gradientConfig.locations }
    set {
      gradientConfig.locations = newValue
      apply()
    }
  }
  private func apply() {
    if let layer = layer as? CAGradientLayer {
      layer.colors = [grColor1.cgColor, grColor2.cgColor]
      layer.startPoint = startPoint
      layer.endPoint = endPoint
      layer.locations = locations
    }
  }
}
