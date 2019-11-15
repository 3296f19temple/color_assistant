//
//  FirstView.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/11/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit

class FirstView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let label = UILabel()
    let openCamera = UIButton()
	var img = #imageLiteral(resourceName: "stacked")
    override func viewDidLoad() {
        super.viewDidLoad()
		//camera()
		var image = img
	
		view.backgroundColor = .white
        setuplabel()
		openCameraSetup()
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
        //label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.text = "Color Assistant"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        //label.textColor = .red
        
    }
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true)

		guard let image = info[.editedImage] as? UIImage else {
			print("No image found")
			return
		}
		var x = image.size.height
		print(x)
		var y = image.size.width
		print(y)
		var centX = x/2
		var cy = y/2
			DispatchQueue.main.async {
				self.view.backgroundColor = image.getPixelColor(pos: CGPoint(x: centX, y: cy))
				
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
      func getPixelColor(pos: CGPoint) -> UIColor {

	                    let pixelData = self.cgImage!.dataProvider!.data
          let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

          let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

          let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
          let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
          let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
          let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

          return UIColor(red: r, green: g, blue: b, alpha: a)
      }
  }
