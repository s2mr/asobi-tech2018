//
//  SupriseCameraViewController.swift
//  merry
//
//  Created by 大川恭平 on 2018/02/28.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
import AudioToolbox
import AVFoundation

class SupriseCameraViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    
    var imageView:UIImageView!
    var timer = Timer()
    
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
    }
    
    func setupCamera(){
        session = AVCaptureSession()
        
        camera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
        
        do{
            input = try AVCaptureDeviceInput(device: camera)
        }catch let error {
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
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        imageView = UIImageView(frame: CGRect(x: (screenWidth/2.0)-50, y: (screenHeight/2.0)-50, width: 100, height: 100))
        imageView.image = UIImage(named: "merry_trace")
        self.view.layer.addSublayer(imageView.layer)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: big)
        
        playVoice(fileName: "shout", type: "mp3")
        
        session.startRunning()
    }
    
    func big(timer: Timer){
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let size = imageView.frame.width
        
        imageView.frame = CGRect(x: (screenWidth/2.0)-(size/2.0), y: (screenHeight/2.0)-(size/2.0), width: size*1.04, height: size*1.04)
        
        if size >= 500 {
            timer.invalidate()
        }
    }
    
    public func playVoice(fileName:String,type:String){
        do{
            let filePath = Bundle.main.path(forResource: fileName, ofType: type)
            let audioPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: audioPath)
            audioPlayer.numberOfLoops = 0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch{
            print("error play merry voice")
        }
    }
}
