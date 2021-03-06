
import UIKit
import AudioToolbox.AudioServices

public typealias ErrorClosure = (String?, String?) -> Void
public typealias SpitterHandler = () -> Void

//extension String {
//  public var localized: String {
//    return NSLocalizedString(self, comment: ".localized")
//  }
//  
//  public func localizeWithFormat(arguments: CVarArg...) -> String{
//    return String(format: self.localized, arguments: arguments)
//  }
//}

extension UIColor {
  public static var defaultTint: UIColor {
    return UIColor(hexString: "#007AFF")
  }
}

public class Spitter {
  public static let blackList = [String]()
  public static var activityIndicators: [UIActivityIndicatorView] = []
  public static func showErrorAlert(_ error: String?, viewController: UIViewController) {
    var permission = true
    blackList.forEach({ if error?.range(of: $0) != nil { permission = false }})
    if permission {
      showAlert("Ooops..", message: error, buttonTitles: ["Close"], actions: [nil], owner: viewController)
    }
  }
  
  class SelectorHandler {
    let c: (() -> Void)?
    var selector: Selector
    
    init(_ c: (() -> Void)?) {
      self.c = c
      selector = #selector(doSelector)
    }
    
    @objc func doSelector() {
      c?()
    }
  }
  
  public static func handleSelector(_ c: (() -> Void)?) -> (object: Any, selector: Selector) {
    let handler = SelectorHandler(c)
    return (object: handler, selector: handler.selector)
  }
  
  public static func showOkAlert(_ message: String?, title: String? = nil, action: SpitterHandler? = nil, viewController: UIViewController) {
    var permission = true
    blackList.forEach({ if message?.range(of: $0) != nil { permission = false }})
    if permission {
      showAlert(title, message: message, buttonTitles: ["Ok"], actions: [action ?? {}], owner: viewController)
    }
  }
  public static func showActionAlert(_ title: String?, message: String?, controller: UIViewController, action: @escaping () -> Void) {
    let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
      action()
    }))
    var permission = true
    blackList.forEach({ if message?.range(of: $0) != nil { permission = false }})
    if permission {
      controller.present(alert, animated: true, completion: nil)
    }
  }
  public static func showActionAlertOnPVC(_ title: String? = nil, message: String?, action: @escaping () -> Void) {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      var permission = true
      blackList.forEach({ if message?.range(of: $0) != nil { permission = false }})
      if permission {
        showActionAlert(title, message: message, controller: topController, action: action)
      }
    }
  }
  public static func pvc() -> UIViewController? {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      return topController
    } else {
      return nil
    }
  }
  public static func rootVC() -> UIViewController? {
    return UIApplication.shared.keyWindow?.rootViewController
  }
  public static func identifier(of object: AnyObject) -> String {
    return String(describing: ObjectIdentifier(object).hashValue)
  }
  public static func showAlertOnPVC(_ title: String? = nil, message: String?, buttonTitles: [String], actions: [(() -> Void)?]) {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      var permission = true
      blackList.forEach({ if message?.range(of: $0) != nil { permission = false }})
      if permission {
        showAlert(title, message: message, buttonTitles: buttonTitles, actions: actions, owner: topController)
      }
    }
  }
  public static func showConfirmation(_ title: String = "Are you sure?", message: String? = nil, owner: UIViewController? = nil, confirmCompletion: @escaping () -> Void) {
    MultiActionAlert(style: .alert, title: title, message: message, buttonTitles: ["Ok", "Cancel"], actionStyles: [.default, .cancel], actions: [ {confirmCompletion()}, {} ], owner: owner ?? pvc())
      .showAlert()
  }
  public static func showAlert(_ title: String? = nil, message: String?, buttonTitles: [String], actions: [(() -> Void)?], owner: UIViewController) {
    MultiActionAlert(style: UIAlertController.Style.alert, title: title, message: message, buttonTitles: buttonTitles, actions: actions, owner: owner).showAlert()
  }
  public static func showSheet(_ title: String? = nil, message: String?, buttonTitles: [String], actions: [(() -> Void)?], styles: [UIAlertAction.Style]? = nil, owner: UIViewController) {
    MultiActionAlert(style: UIAlertController.Style.actionSheet, title: title, message: message, buttonTitles: buttonTitles, actionStyles: styles, actions: actions, owner: owner).showAlert()
  }
  public static func shareUrl(_ urlString: String?, viewController: UIViewController) {
    if let urlString = urlString, let url = URL(string: urlString) {
      let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
      activityVC.popoverPresentationController?.sourceView = viewController.view
      activityVC.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
      viewController.present(activityVC, animated: true, completion: nil)
    }
  }
  public static func showOk(vc: UIViewController? = nil, completion: @escaping () -> Void) {
    if let vc = vc {
      displayOk(vc: vc, completion: completion)
    } else {
      if let pvc = pvc() {
        displayOk(vc: pvc, completion: completion)
      } else if let rootVC = rootVC() {
        displayOk(vc: rootVC, completion: completion)
      }
    }
  }
  private static func displayOk (vc: UIViewController, completion: @escaping () -> Void) {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Office 365"))
    imageView.center = vc.view.center
    vc.view.addSubview(imageView)
    vc.view.bringSubviewToFront(imageView)
    UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
      imageView.alpha = 0
      imageView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
    }) { _ in
      imageView.removeFromSuperview()
      completion()
    }
  }
  public static func showWord(word: String, withColor color: UIColor = .black, vc: UIViewController? = nil, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      if let vc = vc {
        displayWord(word: word, withColor: color, vc: vc, completion: completion)
      } else {
        if let pvc = pvc() {
          displayWord(word: word, withColor: color, vc: pvc, completion: completion)
        } else if let rootVC = rootVC() {
          displayWord(word: word, withColor: color, vc: rootVC, completion: completion)
        }
      }
    }
  }
  
  private static var wordCount: Int = 0 {
    didSet{
      if Spitter.wordCount >= 10 { Spitter.wordCount = 0 }
    }
  }
  
  private static let wordSpacing: CGFloat = 46
  
  private static func displayWord (word: String, withColor color: UIColor, vc: UIViewController, completion:(() -> Void)?) {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    label.text = word
    label.textAlignment = .center
    label.textColor = color
    label.center = vc.view.center
    label.center.y = vc.view.center.y + (-200 + CGFloat(wordCount) * wordSpacing)
    label.numberOfLines = 0
    label.font = UIFont(name: label.font.fontName, size: 30)
    vc.view.addSubview(label)
    vc.view.bringSubviewToFront(label)
    wordCount += 1
    UIView.animate(withDuration: 1.6, delay: 0, options: .curveEaseOut, animations: {
      label.alpha = 0
      label.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
    }) { _ in
      label.removeFromSuperview()
      completion?()
    }
  }
  public static func showSpinner(vc: UIViewController? = nil, style: UIActivityIndicatorView.Style = .gray) {
    if let vc = vc {
      displaySpinner(view: vc.view)
    } else {
      if let rootController = UIApplication.shared.keyWindow?.rootViewController {
        displaySpinner(view: rootController.view)
      }
    }
  }
  public static func hideSpinner(vc: UIViewController? = nil) {
    if let vc = vc {
      removeSpinnerFrom(view: vc.view)
    } else {
      if let rootController = UIApplication.shared.keyWindow?.rootViewController {
        removeSpinnerFrom(view: rootController.view)
      }
    }
  }
  public static func hideSpinner(view: UIView) {
    removeSpinnerFrom(view: view)
  }
  public static func hideAllSpinners() {
    removeAllSpinners()
  }
  
  public static func showSpinner(view: UIView, style: UIActivityIndicatorView.Style = .gray) {
    displaySpinner(view: view, style: style)
  }
  
  private static func displaySpinner(view: UIView, style: UIActivityIndicatorView.Style = .gray) {
    var childpinner: UIActivityIndicatorView? {
      var spinner: UIActivityIndicatorView?
      if let activityView = view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
        spinner = activityView
      }
      spinner?.style = style
      return spinner
    }
    if let childpinner = childpinner {
      childpinner.isHidden = false
      childpinner.startAnimating()
    } else {
      let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
      activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)
      activityIndicator.style = UIActivityIndicatorView.Style.gray
      activityIndicator.center = view.center
      addSubview(subview: activityIndicator, toView: view)
      activityIndicator.startAnimating()
      activityIndicator.style = style
      self.activityIndicators.append(activityIndicator)
    }
  }
  private static func removeSpinnerFrom(view: UIView) {
    for child in view.subviews {
      if let activity = child as? UIActivityIndicatorView {
        activity.stopAnimating()
        activity.removeFromSuperview()
      }
    }
  }
  private static func removeAllSpinners() {
    if !activityIndicators.isEmpty {
      activityIndicators.forEach { activityIndicator in
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
      }
    }
  }
  
  public static func showErrorOnPvc(_ errStr: String, onAction: (() -> Void)? = nil) {
    var permission = true
    blackList.forEach { if errStr.range(of: $0) != nil { permission = false } }
    if permission { tap(.tryAgain); showActionAlertOnPVC("Ooops.." , message: errStr, action: { onAction?() }) }
  }
  
  public static func handleErrorStringClosure(onError: (() -> Void)? = nil, onAction: (() -> Void)? = nil) -> (String) -> Void {
    return { errStr in
      onError?()
      var permission = true
      blackList.forEach { if errStr.range(of: $0) != nil { permission = false } }
      if permission {
        tap(.tryAgain)
        showActionAlertOnPVC("Ooops.." , message: errStr, action: { onAction?() })
      }
    }
  }
  static public func handleError(error: NSError) {
    produceErrorClosure(error: error, errorClosure: handleErrorMessageClosure())
  }
  public static func handleErrorMessageClosure(shouldHideActivityIndicator: Bool = false, completion: (() -> Void)? = nil) -> ErrorClosure {
    return { title, message in
      showActionAlertOnPVC(title, message: message, action: {})
      if shouldHideActivityIndicator { hideSpinner() }
      completion?()
    }
  }
  public static func error(code: Int, description: String) -> NSError {
    return NSError(domain: "Rolique", code: code, userInfo: [NSLocalizedDescriptionKey: description])
  }
  public static func produceErrorClosure(error: NSError, errorClosure: ErrorClosure) {
    errorClosure("Oooops.. ", error.localizedDescription)
    print(error)
  }
  public static func displayErrorOnPVC(error: Error, action: (() -> Void)? = nil) {
    tap(.tryAgain);
    showActionAlertOnPVC("Oooops.. ", message: error.localizedDescription, action: action ?? {})
  }
  static public func showOkAlertOnPVC(_ message: String) {
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      showOkAlert(message, viewController: topController)
    }
  }
  public static func showInputAlert(title: String? = nil,
                                    message: String? = nil,
                                    buttons: [String],
                                    actionStyles: [UIAlertAction.Style]? = nil,
                                    actions: [(() -> Void)?],
                                    owner: UIViewController,
                                    textfieldConfigurationHandler: ((UITextField) -> Void)? = nil) {
    MultiActionAlert(style: .alert,
                     title: title,
                     message: message,
                     buttonTitles: buttons,
                     actionStyles: actionStyles,
                     actions: actions,
                     owner: owner,
                     textfieldConfigurationHandler: textfieldConfigurationHandler
      ).showAlert()
  }
  public static func shareContent(_ text: String?, image: UIImage?, controller: UIViewController) {
    var itemsToShare = [AnyObject]()
    if let text = text { itemsToShare.append(text as AnyObject) }
    if let image = image { itemsToShare.append(image) }
    let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
    activityViewController.completionWithItemsHandler = activityCompletionHandler
    activityViewController.popoverPresentationController?.sourceView = controller.view
    activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
    controller.present(activityViewController, animated: true) { () -> Void in
      print("Sharing view did appear")
    }
  }
  public static func activityCompletionHandler(activityType: UIActivity.ActivityType?, completed: Bool, items: [Any]?, activityError: Error?) {
    if completed && activityError == nil {
      switch activityType! {
      case UIActivity.ActivityType.mail:print("activity finished for mail")
      case UIActivity.ActivityType.message:print("activity finished for message")
      case UIActivity.ActivityType.postToFacebook:print("activity finished for FB")
      case UIActivity.ActivityType.postToTwitter:print("activity finished for TWITTER")
      case UIActivity.ActivityType.postToFlickr:print("activity finished for Flickr")
      case UIActivity.ActivityType.postToVimeo:print("activity finished for Vimeo")
      case UIActivity.ActivityType.postToWeibo:print("activity finished for Weibo")
      default:print("activity finished with other type: \(String(describing: activityType))")
      }
    }
  }
  
  private static func addSubview(subview: UIView, toView parentView: UIView) {
    parentView.addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    var viewBindingsDict = [String: AnyObject]()
    viewBindingsDict["subView"] = subview
    parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", metrics: nil, views: viewBindingsDict))
    parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", metrics: nil, views: viewBindingsDict))
  }
  public static func spit(string: String, errorClosure: (_ title: String?, _ message: String?) -> Void) {
    produceErrorClosure(error: error(code: 777, description: string), errorClosure: errorClosure)
  }
  public static func spit(error: NSError, errorClosure: (_ title: String?, _ message: String?) -> Void) {
    produceErrorClosure(error: error, errorClosure: errorClosure)
  }
  
  public static let feedbackGenerator: (notification: UINotificationFeedbackGenerator, impact: (light: UIImpactFeedbackGenerator, medium: UIImpactFeedbackGenerator, heavy: UIImpactFeedbackGenerator), selection: UISelectionFeedbackGenerator) = {
    return (notification: UINotificationFeedbackGenerator(), impact: (light: UIImpactFeedbackGenerator(style: .light), medium: UIImpactFeedbackGenerator(style: .medium), heavy: UIImpactFeedbackGenerator(style: .heavy)), selection: UISelectionFeedbackGenerator())
  }()
  
  public static func impact() {
    tap(.pop)
  }
  
  public enum TapticEngineSupportLevel: Int {
    case vibroOnly = 0
    case tapticFirst = 1
    case tapticSecond = 2
  }
  
  public enum TapticType {
    case success, fail, peek, pop, cancel, tryAgain, vibro
  }
  
  public static func tap(_ type: Spitter.TapticType) {
    let level = (Spitter.TapticEngineSupportLevel(rawValue: (UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int) ?? 0)) ?? .vibroOnly
    switch type {
    case .vibro:
      let vibrate = SystemSoundID(kSystemSoundID_Vibrate)
      AudioServicesPlaySystemSound(vibrate)
    case .peek:
      if case .tapticSecond = level {
        feedbackGenerator.impact.light.prepare()
        feedbackGenerator.impact.light.impactOccurred()
      } else if case .tapticFirst = level {
        let peek = SystemSoundID(1519)
        AudioServicesPlaySystemSound(peek)
      }
    case .pop:
      if case .tapticSecond = level {
        feedbackGenerator.impact.medium.prepare()
        feedbackGenerator.impact.medium.impactOccurred()
      } else if case .tapticFirst = level {
        let pop = SystemSoundID(1520)
        AudioServicesPlaySystemSound(pop)
      }
    case .cancel:
      if case .tapticSecond = level {
        feedbackGenerator.notification.prepare()
        feedbackGenerator.notification.notificationOccurred(.error)
      } else if case .tapticFirst = level {
        let cancelled = SystemSoundID(1521)
        AudioServicesPlaySystemSound(cancelled)
      }
    case .tryAgain:
      if case .tapticSecond = level {
        feedbackGenerator.notification.prepare()
        feedbackGenerator.notification.notificationOccurred(.warning)
      } else if case .tapticFirst = level {
        let tryAgain = SystemSoundID(1102)
        AudioServicesPlaySystemSound(tryAgain)
      }
    case .fail:
      if case .tapticSecond = level {
        feedbackGenerator.impact.heavy.prepare()
        feedbackGenerator.impact.heavy.impactOccurred()
      } else if case .tapticFirst = level {
        let vibrate = SystemSoundID(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(vibrate)
      }
    case .success:
      if case .tapticSecond = level {
        feedbackGenerator.notification.prepare()
        feedbackGenerator.notification.notificationOccurred(.success)
      } else if case .tapticFirst = level {
        let pop = SystemSoundID(1520)
        AudioServicesPlaySystemSound(pop)
      }
    }
  }
}

public class MultiActionAlert {
  var style: UIAlertController.Style
  var title: String?
  var message: String?
  var buttonTitles: [String]
  var actions: [(() -> Void)?]
  var owner: UIViewController?
  var actionStyles: [UIAlertAction.Style]?
  var textfieldConfigurationHandler: ((UITextField) -> Void)?
  
  public init (style: UIAlertController.Style,
               title: String? = nil,
               message: String? = nil,
               buttonTitles: [String],
               actionStyles: [UIAlertAction.Style]? = nil,
               actions: [(() -> Void)?],
               owner: UIViewController? = nil,
               textfieldConfigurationHandler: ((UITextField) -> Void)? = nil) {
    self.style = style
    self.title = title
    self.message = message
    self.buttonTitles = buttonTitles
    self.actions = actions
    self.owner = owner
    self.actionStyles = actionStyles
    self.textfieldConfigurationHandler = textfieldConfigurationHandler
  }
  
  public init (style: UIAlertController.Style,
               title: String? = nil,
               message: String? = nil,
               actions: [MultiActionAlert.Action],
               owner: UIViewController? = nil,
               textfieldConfigurationHandler: ((UITextField) -> Void)? = nil) {
    self.style = style
    self.title = title
    self.message = message
    self.buttonTitles = actions.map { $0.title }
    self.actions = actions.map { $0.handler }
    self.owner = owner
    self.actionStyles = actions.map { $0.style }
    self.textfieldConfigurationHandler = textfieldConfigurationHandler
  }
  
  public func showAlert() {
    if owner == nil { owner = Spitter.pvc() }
    let alert = UIAlertController(title: self.title, message: self.message, preferredStyle: self.style)
    alert.popoverPresentationController?.sourceView = owner!.view
    alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
    for x in 0..<buttonTitles.count {
      let buttonTitle = self.buttonTitles[x]
      let action =  self.actions[x]
      if let actionStyles = self.actionStyles {
        let style = actionStyles[x]
        alert.addAction(UIAlertAction(title: buttonTitle, style: style, handler: {_ in
          action?()
        }))
      } else {
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
          action?()
        }))
      }
    }
    if textfieldConfigurationHandler != nil {
      alert.addTextField(configurationHandler: self.textfieldConfigurationHandler)
    }
    alert.view.tintColor = .defaultTint
    owner!.present(alert, animated: true, completion: nil)
  }
  
  static let cancelAction: Action = Action(title: "Cancel", style: .destructive)
  
  public class Action {
    var title: String
    var style: UIAlertAction.Style
    var handler: SpitterHandler?
    
    init(title: String, style: UIAlertAction.Style, handler: SpitterHandler? = {}) {
      self.title = title
      self.style = style
      self.handler = handler
    }
  }
}
