
import UIKit

class SystemCatche {
  static let current = SystemCatche()
  private init(){}
  var navBackgroundImage: UIImage?
  var navShadowImage: UIImage?
  var navBackgroundColor: UIColor?
  
  func store(for nav: UINavigationController) {
    navBackgroundImage = nav.navigationBar.backgroundImage(for: .default)// == UIImage() ? navBackgroundImage : nav.navigationBar.backgroundImage(for: .default)
    navShadowImage = nav.navigationBar.shadowImage// == UIImage() ? navShadowImage : nav.navigationBar.shadowImage
    navBackgroundColor = nav.view.backgroundColor// == .clear ? navBackgroundColor : nav.view.backgroundColor
  }
  
  
}

public class NavigationBar: UINavigationBar {
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    barStyle = .blackTranslucent
  }
}

public struct System {
  
  static public func setBackgroundColor(forNav nav: UINavigationController, color: UIColor) {
    let navBar = nav.navigationBar
    navBar.setBackgroundImage(#imageLiteral(resourceName: "white"), for: .default)
    navBar.setBackgroundImage(#imageLiteral(resourceName: "white"), for: .compact)
    //    navBar.shadowImage = UIImage()
    navBar.isTranslucent = true
    nav.view.backgroundColor = color
  }
  
  static public func clearNavigationBar(forNav nav: UINavigationController) {
    let navBar = nav.navigationBar
    navBar.setBackgroundImage(UIImage(), for: .default)
    navBar.shadowImage = UIImage()
    navBar.isTranslucent = true
    nav.view.backgroundColor = .white
  }
  
  static public func restore(for nav: UINavigationController) {
    let n = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    nav.navigationBar.setBackgroundImage(n.navigationBar.backgroundImage(for: .default), for: .default)
    nav.navigationBar.shadowImage = n.navigationBar.shadowImage
    nav.view.backgroundColor = n.view.backgroundColor
  }
  
  static public func setNAvigationBarImage(forBar navBar: UINavigationBar, image: UIImage) {
    navBar.setBackgroundImage(image, for: .default)
    navBar.shadowImage = UIImage()
    navBar.isTranslucent = true
//    navBar.frame = CGRect(x: 0, y: 0, width: navBar.frame.size.width, height: 200.0)
  }
}

