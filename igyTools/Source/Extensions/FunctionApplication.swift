//
//  FunctionApplications.swift
//  iOSmeetup
//
//  Created by bbb on 11/30/18.
//  Copyright © 2018 bbb. All rights reserved.
//

import Foundation

precedencegroup ApplicationPrecedence {
    higherThan: AssignmentPrecedence
    associativity: left
}

infix operator §: ApplicationPrecedence

public func §<A, B>(f: (A) -> B, a: A) -> B {
    return f(a)
}
