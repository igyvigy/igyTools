
import UIKit
public typealias AnimatorHandler = () -> Void

public class Animator {
  public static func perform(_ animation: AnimatorHandler, andAfterThat completion: AnimatorHandler? = nil) {
    CATransaction.begin()
    CATransaction.setCompletionBlock({
      completion?()
    })
    animation()
    CATransaction.commit()
  }
}
