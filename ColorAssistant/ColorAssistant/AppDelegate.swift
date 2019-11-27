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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
		try! setupDatabase(application)
		application.applicationSupportsShakeToEdit = true
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = FirstView()//CameraVC()
		window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

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

