//
//  AppDelegate.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/11/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	   var window: UIWindow?

		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
			application.applicationSupportsShakeToEdit = true
			window = UIWindow(frame: UIScreen.main.bounds)
			window?.rootViewController = CameraVC()
			window?.makeKeyAndVisible()
			return true
		}


    // MARK: UISceneSession Lifecycle

   

}

