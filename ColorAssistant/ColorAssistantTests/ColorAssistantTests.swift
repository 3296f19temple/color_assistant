//
//  ColorAssistantTests.swift
//  ColorAssistantTests
//
//  Created by Ian Applebaum on 11/15/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import XCTest

class ColorAssistantTests: XCTestCase {
	private var f : FirstView?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		f = FirstView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCenterColor() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		let image = #imageLiteral(resourceName: "stacked")
		let detectedColor = image.getCenterColor().cgColor//.components
		let dRed = detectedColor.components![0].rounded()
		let dGreen = detectedColor.components![1].rounded()
		let dBlue = detectedColor.components![2].rounded()
	
		let actual = #colorLiteral(red: 0, green: 0.9568627451, blue: 0.1568627451, alpha: 1).cgColor//.components
		let aRed = actual.components![0].rounded()
		let aGreen = actual.components![1].rounded()
		let aBlue = actual.components![2].rounded()
		
		XCTAssert(dRed == aRed, "not same red value")
		XCTAssert(dGreen == aGreen, "not same green value")
		XCTAssert(dBlue == aBlue, "not same blue value")
		
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
