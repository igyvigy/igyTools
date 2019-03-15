//
//  URL.swift
//  Alamofire
//
//  Created by Bohdan Savych on 1/11/19.
//

import UIKit

public extension URL {
  public var isRemote: Bool {
    return self.path.starts(with: "https://") || self.path.starts(with: "http://")
  }
  
  public func openInSafari() {
    UIApplication.shared.open(self)
  }
}
