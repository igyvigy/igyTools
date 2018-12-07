
import UIKit
public typealias AnimatorHandler = () -> Void

public protocol Animatable {
  var animationBlock: () -> Void { get }
  var completionBlock: (Bool) -> Void { get }
  var animations: [Animator.Animation] { get }
  var preparations: [Animator.Preparation]? { get set }
  var duration: TimeInterval { get }
  var delay: TimeInterval { get }
  var progressWhenInterrupted: CGFloat { get set }
  
  func makeAnimator(curve: UIView.AnimationCurve) -> UIViewPropertyAnimator
//  var completionVlock: (Bool) -> Void { get }
//  var options: [Any] { get }
}

public class Animator {

  public enum Animation {
    case scale(xy: CGFloat)
    case alpha(val: CGFloat)
    case fadeIn
    case fadeOut
  }
  
  public enum Preparation {
    case shrink, hide, resetTransform
  }
  
  public static func perform(_ animation: AnimatorHandler, andAfterThat completion: AnimatorHandler? = nil) {
    CATransaction.begin()
    CATransaction.setCompletionBlock({
      completion?()
    })
    animation()
    CATransaction.commit()
  }
  
  public static func prepare(_ view: UIView, preparations: [Preparation]) {
    for (_, preparation) in preparations.enumerated() {
      switch preparation {
      case .shrink:
        view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
      case .hide:
        view.isHidden = true
      case .resetTransform:
        view.transform = .identity
      }
    }
  }
  
  public static func animate(_ view: UIView, animations: [Animation], duration: TimeInterval, delay: TimeInterval = 0) {
    for (_, animation) in animations.enumerated() {
      switch animation {
      case .fadeIn:
        view.isHidden = false
        view.alpha = 0
      case .alpha(let val):
        if val > 0 { view.isHidden = false }
      default: break
      }
    }
    
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
      for (_, animation) in animations.enumerated() {
        switch animation {
        case .scale(let xy):
          view.transform = CGAffineTransform(scaleX: xy, y: xy)
        case .fadeIn:
          view.alpha = 1
        case .fadeOut:
          view.alpha = 0
        case .alpha(let val):
          view.alpha = val
        }
      }
    }) { success in
      for (_, animation) in animations.enumerated() {
        switch animation {
        case .fadeOut:
          view.isHidden = true
        case .alpha(let val):
          if val == 0 { view.isHidden = true }
        default: break
        }
      }
    }
  }
  
  public static func animateAsAnimatable(_ view: UIView, animations: [Animation], duration: TimeInterval, delay: TimeInterval = 0) {
    Animator.animate(AnimatableObject(view, animations: animations, duration: duration, delay: delay), curve: UIView.AnimationCurve.easeInOut)
  }
  
  public static func animate(_ animatable: Animatable, curve: UIView.AnimationCurve) {
  let animator = UIViewPropertyAnimator(duration: animatable.duration, curve: curve, animations: animatable.animationBlock)
    animator.addCompletion { (animationPosition: UIViewAnimatingPosition) in
      switch animationPosition {
      case .end: animatable.completionBlock(true)
      default: break
      }
    }
    animator.startAnimation(afterDelay: animatable.delay)
  }
  
  public enum DumpingRatio {
    case criticallyDamped//ratio = 1.0
    case underDamped//ration < 1.0
  }
  
  public static func animate(_ animatable: Animatable, dampingRatio: CGFloat) {
    let animator = UIViewPropertyAnimator(duration: animatable.duration, dampingRatio: dampingRatio, animations: animatable.animationBlock)
    animator.startAnimation(afterDelay: animatable.delay)
  }

  public static func handlePan(_ view: UIView, animations: [Animation], duration: TimeInterval, delay: TimeInterval = 0, pan: UIPanGestureRecognizer, curve: UIView.AnimationCurve) {
    var animatable = AnimatableObject(view, animations: animations, duration: duration, delay: delay)
    let animator: UIViewPropertyAnimator = {
      return animatable.makeAnimator(curve: curve)
    }()
    switch pan.state {
    case .began:
      animator.startAnimation()
      animatable.progressWhenInterrupted = animator.fractionComplete
    case .changed:
      let translation = pan.translation(in: Spitter.pvc()?.view)
      animator.fractionComplete = (translation.x / 100) + animatable.progressWhenInterrupted
    case .ended:
      let timing = UICubicTimingParameters(animationCurve: curve)
      animator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
    default: break
    }
  }
  
  

  
}

class AnimatableObject: NSObject,  Animatable {
  
  var view: UIView
  var animations: [Animator.Animation]
  var preparations: [Animator.Preparation]?
  var duration: TimeInterval
  var delay: TimeInterval
  var progressWhenInterrupted: CGFloat = 0
  
  init (_ view: UIView, animations: [Animator.Animation], duration: TimeInterval, delay: TimeInterval = 0) {
    self.view = view; self.animations = animations; self.duration = duration; self.delay = delay
  }
  
  var animationBlock: () -> Void {
    return {
      for (_, animation) in self.animations.enumerated() {
        switch animation {
        case .scale(let xy):
          self.view.transform = CGAffineTransform(scaleX: xy, y: xy)
        case .fadeIn:
          self.view.alpha = 1
        case .fadeOut:
          self.view.alpha = 0
        case .alpha(let val):
          self.view.alpha = val
        }
      }
    }
  }
  
  var completionBlock: (Bool) -> Void {
    return { success in
      for (_, animation) in self.animations.enumerated() {
        switch animation {
        case .fadeOut:
          self.view.isHidden = true
        case .alpha(let val):
          if val == 0 { self.view.isHidden = true }
        default: break
        }
      }
    }
  }
  
  func makeAnimator(curve: UIView.AnimationCurve) -> UIViewPropertyAnimator {
    let animator =  UIViewPropertyAnimator(duration: duration, curve: curve, animations: animationBlock)
//    animator.scrubsLinearly = scrubsLinearly
//    animator.pausesOnCompletion = pausesOnCompletion
    animator.addObserver(self, forKeyPath: "running", options: [.new], context: nil)
    return animator
  }
}
