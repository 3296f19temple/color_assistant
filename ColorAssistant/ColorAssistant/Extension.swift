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
    func name(r: Int, g: Int, b: Int) -> String {
            
            if(((r-200)*-1) < ((r-100)*-1)){
                r = 2 //two represents 255
            }else if(r > 100){
                r = 1 //1 represents 150
            }else{
                r = 0 //0 represents 0
            }
            if(((g-200)*-1) < ((g-100)*-1)){
                g = 2 //two represents 255
            }else if(g > 100){
                g = 1 //1 represents 150
            }else{
                g = 0 //0 represents 0
            }
            if(((b-200)*-1) < ((b-100)*-1)){
                b = 2 //two represents 255
            }else if(b > 100){
                b = 1 //1 represents 150
            }else{
                b = 0 //0 represents 0
            }
            
            if(r == 2 & b == 2 & g == 2){
                return "black"
            }else if(r == 2 & g == 2 & b == 1){
                    return "yellow"
            }else if(r == 2 & g == 2 & b == 0){
                return "orange"
            }else if(r == 2 & g == 1 & b == 2){
                    return "purple"
            }else if(r == 2 & g == 0 & b == 2){
                return "pink"
            }else if(r == 2 & (g == 1 || g == 0)  & (b == 1 || b == 0)){
                return "red"
            }else if(r == 1 & g == 2 & b == 2){
                    return "teal"
            }else if((r == 1 || r == 0) & (g==1 || g == 0 || g == 2) & b == 2){
                return "blue"
            }
            return "i dont know"
        }
}
