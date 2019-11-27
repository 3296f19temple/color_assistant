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



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
		try! setupDatabase(application)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


	private func setupDatabase(_ application: UIApplication) throws {
 		let databaseURL = try FileManager.default
			.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			.appendingPathComponent("colorAssistant.sqlite")
		dbQueue = try AppDatabase.openDatabase(atPath: databaseURL.path)
		print(dbQueue.path)
		// Be a nice iOS citizen, and don't consume too much memory
		// See https://github.com/groue/GRDB.swift/blob/master/README.md#memory-management
		dbQueue.setupMemoryManagement(in: application)
		let a = try! dbQueue.write { db in
			// Create database table
			try db.create(table: "wardrobe", ifNotExists: true) { t in
				t.autoIncrementedPrimaryKey("id")
				t.column("name", .text)//.notNull()
				t.column("path", .text)
				t.column("red", .text)
				t.column("green", .text)
				t.column("blue", .text)
				t.column("alpha", .text)
				t.column("dateAdded", .date)
				
				print("db created")
			}
		}
	}

}

