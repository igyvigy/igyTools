//
//  Functions.swift
//  Spyfall
//
//  Created by bbb on 10/16/18.
//  Copyright © 2018 bbb. All rights reserved.
//

import Foundation

public func id<T>(_ value: T) -> T {
    return value
}

public func cast<From, To>(_ value: From) -> To? {
    return value as? To
}

public func toClosure<T>(_ value: T) -> (() -> T) {
    return { value }
}

public func printObject(_ object: Any) {
    print(object)
}
