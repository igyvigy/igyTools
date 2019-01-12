//
//  URL.swift
//  Alamofire
//
//  Created by Bohdan Savych on 1/11/19.
//

import UIKit

extension URL {
  var isRemote: Bool {
    return self.path.starts(with: "https://") || self.path.starts(with: "http://")
  }
}
