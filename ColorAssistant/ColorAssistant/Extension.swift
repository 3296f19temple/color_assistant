//
//  Extension.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/27/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
	func averageColor(xCoord: Int, yCoord : Int) -> UIColor?{//returns average color within 30X30 square
		guard let inputImage = CIImage(image: self) else { return nil }
		let extentVector = CIVector(x: CGFloat(xCoord), y: CGFloat(yCoord), z: 30, w: 30)

		guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
		guard let outputImage = filter.outputImage else { return nil }

		var bitmap = [UInt8](repeating: 0, count: 4)
		let context = CIContext(options: [.workingColorSpace: kCFNull])
		context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

		return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
	}
	func getPixelColor(pos: CGPoint) -> UIColor {//Returns pixel color at position
		let pixelData = self.cgImage!.dataProvider!.data
		let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
		let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
		let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
		let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
		let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
		let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

		return UIColor(red: r, green: g, blue: b, alpha: a)

	}
	 func getCenterColor() -> UIColor {//returns center pixel color value
		let height = self.size.height
		let width = self.size.width
		let centerY = height/2
		let centerX = width/2
		let center: CGPoint = CGPoint(x: centerX, y: centerY)
		return self.getPixelColor(pos: center)
	}
	func rotate(radians: Float) -> UIImage? {
		var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
		// Trim off the extremely small float value to prevent core graphics from rounding it up
		newSize.width = floor(newSize.width)
		newSize.height = floor(newSize.height)
		
		UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
		let context = UIGraphicsGetCurrentContext()!
		
		// Move origin to middle
		context.translateBy(x: newSize.width/2, y: newSize.height/2)
		// Rotate around middle
		context.rotate(by: CGFloat(radians))
		// Draw the image at its center
		self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage
	}
}
	
extension UIColor {
	var hexString: String {
		let colorRef = cgColor.components
		let r = colorRef?[0] ?? 0
		let g = colorRef?[1] ?? 0
		let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
		let a = cgColor.alpha

		var color = String(
			format: "#%02lX%02lX%02lX",
			lroundf(Float(r * 255)),
			lroundf(Float(g * 255)),
			lroundf(Float(b * 255))
		)

		if a < 1 {
			color += String(format: "%02lX", lroundf(Float(a)))
		}

		return color
	}
	func name() -> String {
		let model = ColorDetector_3()
		let solidImage = UIImage(color: self)
		guard let colorOutput = try? model.prediction(image: self.buffer(from: solidImage!)!)
		else {return ""}
		print("color output \(colorOutput.classLabel)")
		return colorOutput.classLabel
	}
	
		
		
		//if(r == 4 && g == 4 && g == 4){
			   // return "White"
//            }else if((r == 4 || r == 5 || r == 6 || r == 7 || r == 8 || r == 9) && (g == 0 || g == 1 || g == 2 || g == 3)  && (b == 0 || b == 1 || b == 2 || b == 3)){
//                return "Red"
//            }else if((r == 0 || r == 1 || r == 2) && (g == 0 || g == 1 || g == 2 || g == 3) && (b == 4 || b == 5 || b == 6 || b == 7 || b == 8 || b == 9)){
//                return "Blue"
//            }else if((r == 0 || r == 1 || r == 2 || r == 3) && (g == 5 || g == 6 || g == 7 || g == 8 || g == 9) && (b == 0 || b == 1 || b == 2 || b == 3)){
//                return "Green"
//            }else if((r == 9 || r == 9) && (g == 4 || g == 5 || g == 6) && (b == 0 || b == 1 || b == 2 || b == 3)){
//                return "Orange"
//            }else if((r == 4 || r == 5 || r == 6) && (g == 0 || g == 1 || g == 2 || g == 3) && (b == 8 || b == 9)){
//                    return "purple"
//            }else if((r == 9) && (g == 0 || g == 1 || g == 2 || g == 3) && (b == 9)){
//                return "Pink"
//            }else if((r == 0 || r == 1 || r == 2 || r == 3)  && (g == 8 || g == 9) && (b == 8 || b == 2)){
//                    return "Teal"
//            }else if( r == 9 && g == 9 && (b == 0 || b == 1 || b == 2 || b == 3)){
//                    return "Yellow"
//            }
//            return "Try Again"
//        }

func buffer(from image: UIImage) -> CVPixelBuffer? {
  let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
  var pixelBuffer : CVPixelBuffer?
  let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
  guard (status == kCVReturnSuccess) else {
	return nil
  }

  CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
  let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

  let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
  let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

  context?.translateBy(x: 0, y: image.size.height)
  context?.scaleBy(x: 1.0, y: -1.0)

  UIGraphicsPushContext(context!)
  image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
  UIGraphicsPopContext()
  CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

  return pixelBuffer
}
}
	public extension UIImage {
		public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
			let rect = CGRect(origin: .zero, size: size)
			UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
			color.setFill()
			UIRectFill(rect)
			let image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			
			guard let cgImage = image?.cgImage else { return nil }
			self.init(cgImage: cgImage)
		}
	}


