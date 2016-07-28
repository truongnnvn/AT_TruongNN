//
//  AppDelegate.swift
//  AT_TruongNN_Realm_Student
//
//  Created by Truong Nguyen on 7/26/16.
//  Copyright © 2016 TruongNguyen. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        IQKeyboardManager.sharedManager().enable = true
        if let window = window {
            let root = ClassListViewController(nibName: "ClassListViewController", bundle: nil)
            let navi = UINavigationController(rootViewController: root)
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

