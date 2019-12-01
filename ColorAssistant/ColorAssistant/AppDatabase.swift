//
//  AppDatabase.swift
//  ColorAssistant
//
//  Created by Ian Applebaum on 12/1/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

/// A type responsible for initializing the application database.
///
/// See AppDelegate.setupDatabase()
import GRDB
struct AppDatabase {
    
    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        // Connect to the database
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections
        let dbQueue = try DatabaseQueue(path: path)
        
        // Define the database schema
       // try migrator.migrate(dbQueue)
        
        return dbQueue
    }
	 
}
