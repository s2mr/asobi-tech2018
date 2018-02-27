//
//  SupriseCameraViewController.swift
//  merry
//
//  Created by 大川恭平 on 2018/02/28.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit
import AVFoundation

class SupriseCameraViewController: UIViewController {
    
    var input:AVCaptureDeviceInput!
    var output:AVCapturePhotoOutput!
    var session:AVCaptureSession!
    
    var preView:UIView!
    var camera:AVCaptureDevice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupDisplay()
        setupCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        session.stopRunning()
        
        for output in session.outputs{
            session.removeOutput(output)
        }
        
        for input in session.inputs{
            session.removeInput(input)
        }
        
        session = nil
        camera = nil
    }
    
    func setupDisplay(){
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        preView = UIView(frame: CGRect(x: 0.0, y: 0.0,width: screenWidth, height: screenHeight))
//        let imageView = UIImageView(frame: CGRect)
//        preView.addSubview(<#T##view: UIView##UIView#>)
    }
    
    func setupCamera(){
        session = AVCaptureSession()
        
        camera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
        
        do{
            input = try AVCaptureDeviceInput(device: camera)
        }catch let error as Error{
            print(error)
        }
        
        if(session.canAddInput(input)){
            session.addInput(input)
        }
        
        output = AVCapturePhotoOutput()
        
        if(session.canAddOutput(output)){
            session.addOutput(output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        previewLayer.frame = preView.frame
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.view.layer.addSublayer(previewLayer)
        
        session.startRunning()
    }
}
