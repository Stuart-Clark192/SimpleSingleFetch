//
//  SceneDelegate.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var isRunningUnitTests: Bool {
        return NSClassFromString("XCTestCase") != nil
    }
    
    private var isRunningUITests: Bool {
        return ProcessInfo.processInfo.arguments.contains("UITestMode")
    }
    
    private var runLocalTestMode: Bool {
        return ProcessInfo.processInfo.arguments.contains("LocalTestMode")
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let session = isRunningUITests || isRunningUnitTests || runLocalTestMode
            ? URLTestSession.testSession()
            : URLSession.shared
        
        if isRunningUITests || runLocalTestMode {
            URLProtocolMock.response = MockResponses.validResponse
        }
        
        let viewModel = UserViewModel(using: session)
        let userView = UserView(viewModel: viewModel)
        
        if let windowScene = scene as? UIWindowScene {
            
            if !isRunningUnitTests {
                
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: userView)
                self.window = window
                window.makeKeyAndVisible()
            } else {
                print("Running Tests")
            }
        }
    }
}

