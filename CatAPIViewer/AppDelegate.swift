//
//  AppDelegate.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/3/20.
//  Copyright © 2020 Alexey. All rights reserved.

//AppInstance.showLoader()
//AppInstance.hideLoader()
//

import UIKit

var AppInstance: AppDelegate!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppInstance = self
        return true
    }

    //MARK: - Activity Indicator -
    func showLoader()
    {
        CustomLoader.sharedInstance.startAnimation()
    }
    func hideLoader()
    {
        CustomLoader.sharedInstance.stopAnimation()
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

