//
//  UIEdgeInsets.swift
//  Alamofire
//
//  Created by Bohdan Savych on 1/16/19.
//

import UIKit

public extension UIEdgeInsets {
  public var horizontal: CGFloat { return self.left + self.right }
  public var vertical: CGFloat { return self.top + self.bottom }
}

