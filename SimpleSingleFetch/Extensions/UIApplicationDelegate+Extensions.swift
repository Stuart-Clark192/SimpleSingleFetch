//
//  UIApplicationDelegate+Extensions.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 28/10/2020.
//

import UIKit

extension UIApplicationDelegate {
    
    var isRunningUnitTests: Bool {
        return NSClassFromString("XCTestCase") != nil
    }
    
    var isRunningUITests: Bool {
        return ProcessInfo.processInfo.arguments.contains("UITestMode")
    }
    
    var runLocalTestMode: Bool {
        return ProcessInfo.processInfo.arguments.contains("LocalTestMode")
    }
}
