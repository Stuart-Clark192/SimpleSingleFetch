//
//  AppSession.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 28/10/2020.
//

import Foundation

class AppSession {
    
    static let sharedInstance = AppSession()
    static var isRunningTestSession = false
    static var isRunningLocalData = false
    
    let session: URLSession
    
    init() {
        if AppSession.isRunningTestSession {
            session = URLTestSession.testSession()
        } else {
            session = URLSession.shared
        }
    }
}
