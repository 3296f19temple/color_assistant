//
//  FirstView.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/11/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit
import AVFoundation

class FirstView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let captureImageView = UIImageView()
    var outputImage = UIImage()
    let cardView = UIView()
    let dismissButton = UIButton()
    
    
    
    
    let label = UITextView()
    let openCamera = UIButton()
	var img = #imageLiteral(resourceName: "stacked")
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		//camera()
		var image = img

        
        
        cardViewSetup()
        dismissButtonSetup()
        

    }
    
    
    
    
    
    
    
    func captureImageViewSetup() {
        view.addSubview(captureImageView)
        captureImageView.translatesAutoresizingMaskIntoConstraints = false
        captureImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        captureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        captureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        captureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        captureImageView.image = outputImage
    }
    
    func cardViewSetup() {
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
    }
    
    func dismissButtonSetup() {
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
	func camera()  {
		let vc = UIImagePickerController()
		vc.sourceType = .camera
		vc.allowsEditing = true
		vc.delegate = self
		present(vc, animated: true)
	}
    
    func setuplabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        //label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.text = "Color Assistant"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.backgroundColor = .clear
        label.textAlignment = .center
        
        //label.textColor = .red
        
    }
	
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true)

		guard let image = info[.editedImage] as? UIImage else {
			print("No image found")
			return
		}
        let centX = Int(image.size.width / 2) - 15
        let centY = Int(img.size.height / 2) - 15
        
        let centerColor = image.averageColor(xCoord: centX, yCoord: centY)
		DispatchQueue.main.async {
				self.view.backgroundColor = centerColor
				self.label.text = centerColor!.description
                self.label.font = UIFont.systemFont(ofSize: 12)

			}
		// print out the image size as a test
		print(image.size)
	}
	func openCameraSetup() {
		view.addSubview(openCamera)
		openCamera.translatesAutoresizingMaskIntoConstraints = false
		openCamera.heightAnchor.constraint(equalToConstant: 50).isActive = true
		openCamera.widthAnchor.constraint(equalToConstant: 200).isActive = true
		openCamera.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		openCamera.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		openCamera.backgroundColor = .blue
		openCamera.addTarget(self, action: #selector(openCameraClicked), for: .touchUpInside)
		//openCamera.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		//openCamera.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
    
	@objc func openCameraClicked() {
		print("Button Clicked")
		camera()
	}
	
	
}
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
}
