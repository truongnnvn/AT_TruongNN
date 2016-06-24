//
//  AppDelegate.swift
//  Bai2
//
//  Created by Truong Nguyen on 6/23/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            let Login = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let navi = UINavigationController(rootViewController: Login)
            window.rootViewController = navi
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}

