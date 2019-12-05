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
    var tapGestureRecognizer = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewSetup()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        tap.numberOfTapsRequired = 1

        view.addGestureRecognizer(tap)
 
    }
    
    func tap(sender:UITapGestureRecognizer){

        if sender.state == .ended {

            var touchLocation: CGPoint = sender.location(in: sender.view)
            print(touchLocation.x, touchLocation.y)
            //touchLocation = self.convertPointFromView(touchLocation)

        }
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
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapGestureRecognizerTapped() {
        print("hello")
        //print(sender.location(in: imageView).x)
    }
    

    

}
