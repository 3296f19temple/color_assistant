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

    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    func imageViewSetup() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    

    

}
