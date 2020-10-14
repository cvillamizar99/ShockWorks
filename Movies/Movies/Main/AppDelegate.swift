//
//  AppDelegate.swift
//  Movies
//
//  Created by Carlos Villamizar on 10/13/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow()
        
        window?.setRootViewController(UINavigationController(rootViewController: GeneralRoute.main.scene!), options: .init(direction: .toTop, style: .easeInOut))
        
        return true
    }
}

