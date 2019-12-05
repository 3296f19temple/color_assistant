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
        let location = sender.location(in: imageView)
        print(location.x, location.y)
        crosshair.center = location
        
        
        let vc = OutputVC()
        vc.pointFromColorPicker = location
        vc.outputImage = UIImage(named: "sampleImage")!
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func imageViewSetup() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.image = UIImage(named: "sampleImage")
        imageView.isUserInteractionEnabled = true
    }
    

}
