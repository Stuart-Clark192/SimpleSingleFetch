//
//  AppDelegate.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppSession.isRunningTestSession = isRunningUITests || isRunningUnitTests || runLocalTestMode
        
        if isRunningUITests || runLocalTestMode {
            URLProtocolMock.response = MockResponses.validResponse
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

