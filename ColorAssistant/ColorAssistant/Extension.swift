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
    func name(red: CGFloat, green: CGFloat, blue: CGFloat) -> String {
           
        var r = 0
        var g = 0
        var b = 0

        if(((red-225) > 0)){
                r = 9
            }else if(red > 200){
                r = 8
            }else if(red > 175){
                r = 7
            }else if(red > 150){
                r = 6
            }else if(red > 125){
                r = 5
            }else if(red > 100){
                r = 4
            }else if(red > 75){
                r = 3
            }else if(red > 50){
                r = 2
            }else if(red > 25){
                r = 1
            }else{
                r = 0
            }
        
        if(((green-225) > 0)){
                g = 9
            }else if(green > 200){
                g = 8
            }else if(green > 175){
                g = 7
            }else if(green > 150){
                g = 6
            }else if(green > 125){
                g = 5
            }else if(green > 100){
                g = 4
            }else if(green > 75){
                g = 3
            }else if(green > 50){
                g = 2
            }else if(green > 25){
                g = 1
            }else{
                g = 0
            }
        
        if(((blue-225) > 0)){
                b = 9
            }else if(blue > 200){
                b = 8
            }else if(blue > 175){
                b = 7
            }else if(blue > 150){
                b = 6
            }else if(blue > 125){
                b = 5
            }else if(blue > 100){
                b = 4
            }else if(blue > 75){
                b = 3
            }else if(blue > 50){
                b = 2
            }else if(blue > 25){
                b = 1
            }else{
                b = 0
            }
            
            if((r == 9 || r == 8) && (b == 9 || b == 8) && (g == 9 || g == 8)){
                return "white"
            }
            if((r == 0 || r == 1) && (b == 1 || b == 0) && (g == 1 || g == 0)){
                return "black"
            }
			if((r == 4 || r == 5 || r == 6 || r == 7 || r == 8 || r == 9) && (g == 0 || g == 1 || g == 2 || g == 3)  && (b == 0 || b == 1 || b == 2 || b == 3)){
				return "Red"
			}else if((r == 0 || r == 1 || r == 2) && (g == 0 || g == 1 || g == 2 || g == 3 || g == 4 || g == 5) && (b == 4 || b == 5 || b == 6 || b == 7 || b == 8 || b == 9)){
				return "Blue"
			}else if((r == 0 || r == 1 || r == 2 || r == 3) && (g == 5 || g == 6 || g == 7 || g == 8 || g == 9) && (b == 0 || b == 1 || b == 2 || b == 3)){
				return "Green"
			}else{
				 if((r == 8 || r == 9) && (g == 4 || g == 5 || g == 6) && (b == 0 || b == 1 || b == 2 || b == 3)){
						return "Orange"
					}else if((r == 4 || r == 5 || r == 6) && (g == 0 || g == 1 || g == 2 || g == 3) && (b == 6 || b == 7 || b == 8 || b == 9)){
						return "purple"
					}else if((r == 9) && (g == 0 || g == 1 || g == 2 || g == 3) && (b == 9)){
						return "Pink"
					}else if((r == 0 || r == 1 || r == 2 || r == 3)  && (g == 8 || g == 9) && (b == 8 || b == 2)){
						return "Teal"
					}else if((r == 8 || r == 9) && (g == 8 || g == 9) && (b == 0 || b == 1 || b == 2 || b == 3)){
						return "Yellow"
				}else{
						return "Try Again"
				}
			}
		}
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

