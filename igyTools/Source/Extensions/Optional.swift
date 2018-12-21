//
//  Optional.swift
//  GetGrub
//
//  Created by Bohdan Savych on 12/16/17.
//  Copyright © 2017 ROLIQUE. All rights reserved.
//

import UIKit

public extension Optional {
    public func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap { value in
            transform.map { $0(value) }
        }
    }
    
    public func apply<Value, Result>(_ value: Value?) -> Result?
        where Wrapped == (Value) -> Result
    {
        return value.apply(self)
    }
    
    public func flatten<Result>() -> Result?
        where Wrapped == Result?
    {
        return self.flatMap { $0 }
    }
    
    public func `do`(_ action: (Wrapped) -> ()) {
        self.map(action)
    }
}

public extension Optional where Wrapped == String {
    public var orEmpty: String {
        return self ?? ""
    }
}

public extension Optional where Wrapped == Int {
    public var orZero: Int {
        return self ?? 0
    }
}

public extension Optional where Wrapped == Bool {
  public var orFalse: Bool {
    return self ?? false
  }
}

public extension Optional where Wrapped == Array<Any> {
  public var orEmpty: [Wrapped.Element] {
    return self ?? []
  }
}

public extension Optional where Wrapped == Double {
    public var orZero: Double {
        return self ?? 0
    }
    
    public var orMax: Double {
        return self ?? Double.greatestFiniteMagnitude
    }
}

public extension Optional where Wrapped == CGFloat {
    public var orZero: CGFloat {
        return self ?? 0
    }
    
    public var orMax: CGFloat {
        return self ?? CGFloat.greatestFiniteMagnitude
    }
}

public extension Optional where Wrapped == Date {
    public var orCurrent: Date {
        return self ?? Date()
    }
}
