//
//  ColorPickerVC.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 12/4/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit

class ColorPickerVC: UIViewController {
    
    let imageView = UIImageView()
    let crosshair = UIImageView()
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewSetup()
        crosshairSetup()
        
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
    }
    
    func crosshairSetup(){
        view.addSubview(crosshair)
        crosshair.translatesAutoresizingMaskIntoConstraints = false
        crosshair.heightAnchor.constraint(equalToConstant: 50).isActive = true
        crosshair.widthAnchor.constraint(equalToConstant: 50).isActive = true
        crosshair.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        crosshair.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        crosshair.image = #imageLiteral(resourceName: "crosshair")
    }

    
    @objc func gestureRecognizerTapped(_ sender: UITapGestureRecognizer) {
        let vc = OutputVC()
        vc.outputImage = image
       
        var location = sender.location(in: imageView)
        
        
        print(location.x, location.y)
        crosshair.center = location
       
        //let newLocation = imageView.mapPointThroughAspectFill(uiViewPoint: location)
        let newLocation = convertTapToimage(location)
        
        
        
        vc.pointFromColorPicker = newLocation
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func convertTapToimage(_ point: CGPoint) -> CGPoint? {
        let xRatio = imageView.frame.width / image.size.width
        let yRatio = imageView.frame.height / image.size.height
        let ratio = min(xRatio, yRatio)

        let imageWidth = image.size.width * ratio
        let imageHeight = image.size.height * ratio

        var tap = point
        var borderWidth: CGFloat = 0
        var borderHeight: CGFloat = 0
        // detect border
        if ratio == yRatio {
            // border is left and right
            borderWidth = (imageView.frame.size.width - imageWidth) / 2
            if point.x < borderWidth || point.x > borderWidth + imageWidth {
                return nil
            }
            tap.x -= borderWidth
        } else {
            // border is top and bottom
            borderHeight = (imageView.frame.size.height - imageHeight) / 2
            if point.y < borderHeight || point.y > borderHeight + imageHeight {
                return nil
            }
            tap.y -= borderHeight
        }

        let xScale = tap.x / (imageView.frame.width - 2 * borderWidth)
        let yScale = tap.y / (imageView.frame.height - 2 * borderHeight)
        let pixelX = image.size.width * xScale
        let pixelY = image.size.height * yScale
        return CGPoint(x: pixelX, y: pixelY)
    }
    
    
    func imageViewSetup() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
    }
    func getImage() -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //stackViewGlobal.isHidden = false//
        return image!
    }

}
