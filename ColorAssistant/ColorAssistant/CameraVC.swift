//
//  CustomCamera.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/15/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController, AVCapturePhotoCaptureDelegate {

    var previewView = UIView()
    var captureImageView = UIImageView()
    var takePhotoButton = UIButton()
    
    var captureSession = AVCaptureSession()
    var stillImageOutput = AVCapturePhotoOutput()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    let crosshair = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high//CompatabilityCheck().resolutionCompatability()
        previewViewSetup()
        takePhotoButtonSetup()
        crosshairSetup()
        
		guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back Camera")
            return
        }
        
        var input:AVCaptureDeviceInput!
        
        do{
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error {
            print("Error: Unable to initialize back camera: \(error.localizedDescription)")
        }
        
        stillImageOutput = AVCapturePhotoOutput()
        
        if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
            captureSession.addInput(input)
            captureSession.addOutput(stillImageOutput)
            setupLivePreview()
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
        
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.previewView.bounds
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        previewView.layer.addSublayer(videoPreviewLayer)
    }
    
    func previewViewSetup() {
        view.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        previewView.backgroundColor = .black
    }
    
    func takePhotoButtonSetup() {
        view.addSubview(takePhotoButton)
        takePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        takePhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        takePhotoButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        takePhotoButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        takePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takePhotoButton.addTarget(self, action: #selector(takePhotoButtonTapped), for: .touchUpInside)
        //takePhotoButton.backgroundColor = .red
        takePhotoButton.setImage(UIImage(named: "shotButton"), for: .normal)
        //takePhotoButton.setTitle("Capture", for: .normal)
        
    }
    
    @objc func takePhotoButtonTapped() {
        print("Take photo tapped")
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        
        let image = UIImage(data: imageData)
        let vc = OutputVC()
		vc.outputImage = (image?.rotate(radians: .pi*2)!)!
		vc.img = image!
		if #available(iOS 13, *) {
			
		} else {
			vc.modalPresentationStyle = .overCurrentContext
			
		}
        present(vc, animated: true, completion: nil)
        captureImageViewSetup()
        vc.outputImage = image!
        //vc.cardView.backgroundColor = image?.getCenterColor()
        //captureImageView.image = image
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
        
    }
    
    func captureImageViewSetup() {
        view.addSubview(captureImageView)
        captureImageView.translatesAutoresizingMaskIntoConstraints = false
        //captureImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //captureImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        captureImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        captureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        captureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        captureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    

}

