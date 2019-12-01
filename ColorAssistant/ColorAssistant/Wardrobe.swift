//
//  Wardrobe.swift
//  ColorAssistant
//
//  Created by Ian Applebaum on 11/22/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

/*
Using GRDB, our goal is to organize clothing by color. We save the path to the image of each of the articles of clothing, 
*/

import Foundation
import UIKit
import GRDB
struct Wardrobe  {
	var id: Int64?
	var name:String?
	var path: String?
	var red:CGFloat?
	var green:CGFloat?
	var blue:CGFloat?
	var alpha:CGFloat?
	var dateAdded: Date?
}
extension Wardrobe: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
   private enum Columns {
	 static let name = Column(CodingKeys.name)
	static let path = Column(CodingKeys.path)
	 static let red = Column(CodingKeys.red)
	 static let green = Column(CodingKeys.green)
	 static let blue = Column(CodingKeys.blue)
	 static let alpha = Column(CodingKeys.alpha)
	static let dateAdded = Column(CodingKeys.dateAdded)
	}
	
	// Update a Professor id after it has been inserted in the database.
	mutating func didInsert(with rowID: Int64, for column: String?) {
		id = rowID
	}
}

// MARK: - Database access

// Define some useful Professor requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Wardrobe {
    static func orderedByName() -> QueryInterfaceRequest<Wardrobe> {
        return Wardrobe.order(Columns.name)
    }
    
    static func orderedByred() -> QueryInterfaceRequest<Wardrobe> {
        return Wardrobe.order(Columns.red.desc, Columns.name)
    }
	
	static func orderByDateAdded() -> QueryInterfaceRequest<Wardrobe>{
		return Wardrobe.order(Columns.dateAdded.desc, Columns.name)
	}
//	static func orderByNeedEmail() -> QueryInterfaceRequest<Professor>{
//		return Professor.order(Columns.emailed)
//	}
}
