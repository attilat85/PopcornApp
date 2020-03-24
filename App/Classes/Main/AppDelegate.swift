//
//  AppDelegate.swift
//  iOS Starter Project
//
//  Created by Halcyon Mobile on 5/17/17.
//  Copyright © 2017 HalcyonMobile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flow: RootFlow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        flow = RootFlow(window: window)
        flow?.start()
        
        return true
    }
}
