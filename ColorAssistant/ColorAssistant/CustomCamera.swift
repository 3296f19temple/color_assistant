//
//  CustomCamera.swift
//  ColorAssistant
//
//  Created by Likhon Gomes on 11/15/19.
//  Copyright © 2019 Likhon Gomes. All rights reserved.
//

import UIKit
import AVFoundation

class CustomCamera: UIViewController {

    let captureSession = AVCaptureSession()
    //let rearCamera = AVCaptureDevice?
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
      
        // Do any additional setup after loading the view.
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInTripleCamera], mediaType: .video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
    }
    
    func setupInputOutput() {
        
    }
    
    func setupPreviewLayer() {
        
    }
    
    func startRunningCapture() {
         
    }
}
