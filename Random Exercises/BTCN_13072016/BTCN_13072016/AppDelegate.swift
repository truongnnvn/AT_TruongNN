//
//  AppDelegate.swift
//  BTCN_13072016
//
//  Created by Truong Nguyen on 7/13/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            let root = RootViewController(nibName: "RootViewController", bundle: nil)
            //let navi = UINavigationController(rootViewController: Login)
            window.rootViewController = root
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

