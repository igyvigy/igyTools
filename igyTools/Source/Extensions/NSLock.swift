//
//  NSLock.swift
//  Spyfall
//
//  Created by bbb on 10/16/18.
//  Copyright © 2018 bbb. All rights reserved.
//

import Foundation

public extension NSLocking {
    public func `do`<Result>(_ action: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        return action()
    }
}
