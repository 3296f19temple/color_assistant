//
//  OutputVC.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/22/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit

class OutputVC: UIViewController {

    let captureImageView = UIImageView()
    var outputImage = UIImage()
    let cardView = UIView()
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //captureImageViewSetup()
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
        cardView.layer.cornerRadius = 20
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

    
}
