//
//  AppDelegate.swift
//  ATDemo
//
//  Created by AsianTech on 7/11/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    class var sharedInstance: AppDelegate {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: AppDelegate? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = UIApplication.sharedApplication().delegate as? AppDelegate
        }
        return Static.instance!
    }

    var window: UIWindow?
    var loginNavigation: UINavigationController?
    var mainTabbar: UITabBarController?
    var splashTimer:NSTimer?
    var storyboard:UIStoryboard?
    var plistPathInDocument:String = String()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window =  UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        //Here set the splashScreen VC
        if let window = self.window {
            
            let rootController = SplashVC(nibName: "SplashVC", bundle: nil)
            window.rootViewController = rootController
            
        }
        //Set Timer
        splashTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(AppDelegate.splashTimerCrossedTimeLimit), userInfo: nil, repeats: true)
        return true
    }

    func splashTimerCrossedTimeLimit(){
        
        //Here change the root controller

        if self.window != nil {
            
        let signupAndLoginVC = SignupAndLoginVC(nibName: "SignupAndLoginVC", bundle: nil)
        self.loginNavigation = UINavigationController(rootViewController: signupAndLoginVC)
        
        let homeNavigation = UINavigationController()
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        homeVC.title = "Home"
        homeNavigation.viewControllers = [homeVC]
        homeNavigation.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 1)

        let favoriteNavigation = UINavigationController()
        let favoriteVC = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
        favoriteVC.title = "Favorite"
        favoriteNavigation.viewControllers = [favoriteVC]
        favoriteNavigation.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite"), tag: 2)

        let mapNavigation = UINavigationController()
        let mapVC = MapViewController(nibName: "MapViewController", bundle: nil)
        mapVC.title = "Map"
        mapNavigation.viewControllers = [mapVC]
        mapNavigation.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map"), tag: 3)
            
        let settingsNavigation = UINavigationController()
        let settingsVC = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        settingsVC.title = "Setting"
        settingsNavigation.viewControllers = [settingsVC]
        settingsNavigation.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 4)
       
        mainTabbar = UITabBarController()
        mainTabbar?.viewControllers = [homeNavigation, favoriteNavigation, mapNavigation, settingsNavigation]
        mainTabbar?.tabBar.tintColor = UIColor.blueColor()
        
        self.window!.rootViewController = signupAndLoginVC
        self.window?.makeKeyAndVisible()
        }
        splashTimer?.invalidate()
    }
    
    func changeRootWhenLoginSuccess() {
        if let window = self.window {
            self.mainTabbar?.selectedIndex = 0
            window.rootViewController = self.mainTabbar
        }
    }
    
    func changeRootWhenLogout() {
        if let window = self.window {
            let loginViewController = SignupAndLoginVC(nibName: "SignupAndLoginVC", bundle: nil)
            loginNavigation = UINavigationController(rootViewController: loginViewController)
            
            UIView.transitionWithView(window, duration: 0.6, options: UIViewAnimationOptions.TransitionCrossDissolve,
                                      animations: {
                                        window.rootViewController = self.loginNavigation
                }, completion: nil)
            self.mainTabbar?.reloadInputViews()
        }
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

