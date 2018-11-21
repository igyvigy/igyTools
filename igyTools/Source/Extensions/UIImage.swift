
import Foundation

public extension UIImage {  
  public func tintWithColor(color: UIColor)-> UIImage? {
    UIGraphicsBeginImageContext(self.size)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    context.scaleBy(x: 1.0, y: -1.0);
    context.translateBy(x: 0.0, y: -self.size.height)
    context.setBlendMode(.multiply)
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    if let cgImage = cgImage {
      context.clip(to: rect, mask: cgImage)
    }
    color.setFill()
    context.fill(rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
  
}
