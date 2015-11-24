//
//  AppDelegate.swift
//  swiftDemo2
//
//  Created by 辉贾 on 15/11/7.
//  Copyright © 2015年 RJ. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBar: UITabBarController = UITabBarController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        
        
        
        let first = RJFirstViewController()
        let firstNav: UINavigationController = UINavigationController(rootViewController: first)
        firstNav.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "First"), tag: 1000)
        
        let second = RJSecondViewController()
        let secondNav: UINavigationController = UINavigationController(rootViewController: second)
        secondNav.tabBarItem = UITabBarItem(title: "财富中心", image: UIImage(named: "Second"), tag: 1001)
        
        let third = RJThirdViewController()
        let thirdNav: UINavigationController = UINavigationController(rootViewController: third)
        thirdNav.tabBarItem = UITabBarItem(title: "众筹", image: UIImage(named: "Third"), tag: 1002)

        let four = RJFourViewController()
        let fourNav: UINavigationController = UINavigationController(rootViewController: four)
        fourNav.tabBarItem = UITabBarItem(title: "我的财富", image: UIImage(named: "Four"), tag: 1003)
        
        self.tabBar = UITabBarController()
        self.tabBar.viewControllers = [firstNav, secondNav, thirdNav, fourNav]
        self.tabBar.tabBar.tintColor = UIColor.redColor()
        self.window!.rootViewController = self.tabBar
        
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

