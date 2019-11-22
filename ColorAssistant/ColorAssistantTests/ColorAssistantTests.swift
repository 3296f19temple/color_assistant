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
		let image = #imageLiteral(resourceName: "centerPixelGreen")
        let detectedColor = image.getCenterColor().cgColor
		let dRed = detectedColor.components![0]
		let dGreen = detectedColor.components![1]
		let dBlue = detectedColor.components![2]
	
		let actual = #colorLiteral(red: 0, green: 0.9568627451, blue: 0.1568627451, alpha: 1).cgColor//.components
		let aRed = actual.components![0]
		let aGreen = actual.components![1]
		let aBlue = actual.components![2]
		
		let sig = NumberFormatter()
		sig.numberStyle = .decimal
		sig.maximumFractionDigits = 2
		
		XCTAssert(sig.string(for: String(describing: dRed))  == sig.string(for: String(describing: aRed)), "not same red value. Detected red:\(String(describing: sig.string(for: String(describing: dRed)))) Actual: \(String(describing: sig.string(for: String(describing: aRed))))")
		
		XCTAssert(sig.string(for: String(describing: dGreen))  == sig.string(for: String(describing: aGreen)), "not same green value. Detected green: \(String(describing: sig.string(for: String(describing: dGreen)))) Actual: \(String(describing: sig.string(for: String(describing: aGreen))))")
		
		XCTAssert(sig.string(for: String(describing: dBlue))  == sig.string(for: String(describing: aBlue)), "not same blue value. Detected blue: \(String(describing: sig.string(for: String(describing: dBlue)))) Actual: \(String(describing: sig.string(for: String(describing: aBlue))))")
		
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
