//
//  AppDelegate.swift
//  AppEventCount
//
//  Created by Devere Weaver on 12/24/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // count the number of times the app has launched
    var launchCount = 0
        
    // count the number of times it has created a configuration for connecting to a scence
    var configurationForConnectingCount = 0


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // increment the number of times the app is launched
        launchCount += 1
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        // increment count for configurating a connection to a scene
        configurationForConnectingCount += 1
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

