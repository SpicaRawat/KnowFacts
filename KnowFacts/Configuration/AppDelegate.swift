//
//  AppDelegate.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setInitialController()
        return true
    }
}

extension AppDelegate {
    // MARK: - INITIAL CONTROLLER
    func setInitialController() {
        let rootVC = FF_HomeVC()
        let navBarVC = UINavigationController(rootViewController: rootVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navBarVC
    }
    
    // MARK: - Appdelegate
    class func delegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
