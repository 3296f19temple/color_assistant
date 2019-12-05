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
	/*COLOR NAMING TESTS*/
	func testGreen(){//Colors should return the name green
		let greens = [ #colorLiteral(red: 0.3411764705882353, green: 0.6235294117647059, blue: 0.16862745098039217, alpha: 1.0) , #colorLiteral(red: 0.286, green: 0.529, blue: 0.341, alpha: 1.0) , #colorLiteral(red: 0.373, green: 0.561, blue: 0.318, alpha: 1.0)]
		for color in greens{
			XCTAssert(color.name() == "Green", "color name for \(color.cgColor.components![0]*255) \(color.cgColor.components![1]*255) \(color.cgColor.components![2]*255) : \(color.name()) NOT Green")
		}
		
	}
	func testYellow(){
		let yellows : [UIColor] = [#colorLiteral(red: 0.922, green: 0.8, blue: 0.353, alpha: 1.0) ,#colorLiteral(red: 0.933, green: 0.816, blue: 0.369, alpha: 1.0) ,#colorLiteral(red: 0.933, green: 0.816, blue: 0.365, alpha: 1.0)]
		for color in yellows{
			XCTAssert(color.name() == "Yellow", "color name for \(color.cgColor.components![0]*255) \(color.cgColor.components![1]*255) \(color.cgColor.components![2]*255) : \(color.name()) NOT Yellow")
		}

	}
	func testRed(){
		let reds : [UIColor] = [#colorLiteral(red: 1, green: 0.1480042934, blue: 0.2013355792, alpha: 1) ,#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
		for color in reds{
			XCTAssert(color.name() == "Red", "color name for \(color.cgColor.components![0]*255) \(color.cgColor.components![1]*255) \(color.cgColor.components![2]*255) : \(color.name()) NOT RED")
		}

	}
	func testBlue(){
//		let blues : [UIColor] = [#colorLiteral(red: 0.1057306454, green: 0.07683626562, blue: 0.7717686892, alpha: 1) ,#colorLiteral(red: 0.04939370602, green: 0.07599724084, blue: 0.4180933237, alpha: 1), #colorLiteral(red: 0, green: 0.4136321247, blue: 0.7653703094, alpha: 1), #colorLiteral(red: 0.02760412544, green: 0.09743257612, blue: 0.4566787481, alpha: 1)]
		let blues : [UIColor] = [ #colorLiteral(red: 0.03137254902, green: 0.04705882353, blue: 0.3215686275, alpha: 1)]
		for color in blues{
			XCTAssert(color.name() == "Blue", "color name for \(color.cgColor.components![0]*255) \(color.cgColor.components![1]*255) \(color.cgColor.components![2]*255) : \(color.name()) NOT BLUE")
		}

	}
	func testOrange(){
		let oranges : [UIColor] = [#colorLiteral(red: 1, green: 0.4371963143, blue: 0, alpha: 1) ,#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 1, green: 0.1706156433, blue: 0, alpha: 1)]
		for color in oranges{
			XCTAssert(color.name() == "Orange", "color name for \(color.cgColor.components![0]*255) \(color.cgColor.components![1]*255) \(color.cgColor.components![2]*255) : \(color.name()) NOT Orange")
		}

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
