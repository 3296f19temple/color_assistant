//
//  AppDelegate.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/11/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit
import GRDB

// The shared database queue
var dbQueue: DatabaseQueue!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	   var window: UIWindow?

		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
			try! setupDatabase(application)
			application.applicationSupportsShakeToEdit = true
			window = UIWindow(frame: UIScreen.main.bounds)
			window?.rootViewController = CameraVC()
			window?.makeKeyAndVisible()
			return true
		}

	private func setupDatabase(_ application: UIApplication) throws {
		 let databaseURL = try FileManager.default
			 .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			 .appendingPathComponent("db.sqlite")
		 dbQueue = try AppDatabase.openDatabase(atPath: databaseURL.path)
		 
		 // Be a nice iOS citizen, and don't consume too much memory
		 // See https://github.com/groue/GRDB.swift/blob/master/README.md#memory-management
		 dbQueue.setupMemoryManagement(in: application)
	 }
    // MARK: UISceneSession Lifecycle

   

}

