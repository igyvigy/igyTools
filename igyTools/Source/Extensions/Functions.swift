//
//  Functions.swift
//  Spyfall
//
//  Created by bbb on 10/16/18.
//  Copyright © 2018 bbb. All rights reserved.
//

import Foundation

func id<T>(_ value: T) -> T {
    return value
}

func cast<From, To>(_ value: From) -> To? {
    return value as? To
}

func toClosure<T>(_ value: T) -> (() -> T) {
    return { value }
}

func printObject(_ object: Any) {
    print(object)
}
