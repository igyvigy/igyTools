//
//  Reusable.swift
//  abl
//
//  Created by AliSoftware on 12/17/16.
//  Copyright © 2016 Perpetio. All rights reserved.
//

import Foundation

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static public var reuseIdentifier: String {
        return String(describing: self)
    }
}

public typealias NibReusable = Reusable & NibLoadable
