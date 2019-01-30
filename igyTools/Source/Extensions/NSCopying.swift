//
//  NSCopying.swift
//  igyTools
//
//  Created by Bohdan Savych on 1/30/19.
//  Copyright © 2019 rolique. All rights reserved.
//

import Foundation

extension NSCopying {
  func copiedObject<T>() -> T {
    return self.copy() as! T
  }
}
