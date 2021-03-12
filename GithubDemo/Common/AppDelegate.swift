//
//  AppDelegate.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigator: Navigator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        navigator = Navigator.init(window: window!)

        navigator?.start()
        return true
    }

}

