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
import RxSwift

class SupriseCameraViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    
    var imageView: UIImageView!

    var input: AVCaptureDeviceInput!
    var output: AVCapturePhotoOutput!
    var session: AVCaptureSession!

    let disposeBag = DisposeBag()
    
    var preView:UIView!
    var camera:AVCaptureDevice!
    let restartButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle("もう一度プレイする", for: .normal)
        b.layer.cornerRadius = 8
        b.layer.masksToBounds = true
        b.backgroundColor = .black
        b.alpha = 0.0
        b.sizeToFit()
        return b
    }()

    let gameoverLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.text = "Gameover"
        l.sizeToFit()
        l.font = UIFont(name: "Futura-CondensedExtraBold", size: 50)
        l.textAlignment = .center
        l.textColor = .white
        l.alpha = 0.0
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let ancestor = self?.presentingViewController as? UINavigationController else { return }
            self?.dismiss(animated: true) {
                ancestor.popToRootViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupDisplay()
        setupCamera()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 3.0, delay: 0.0, options: .allowUserInteraction, animations: { [weak self] in
                self?.restartButton.alpha = 0.7
                self?.gameoverLabel.alpha = 1.0
            }, completion: nil)
        }
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
    
    private func setupDisplay(){
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        preView = UIView(frame: CGRect(x: 0.0, y: 0.0,width: screenWidth, height: screenHeight))
    }
    
    private func setupCamera(){
        session = AVCaptureSession()

        guard let camera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                                   for: AVMediaType.video, position: .front) else { return }
        do{
            input = try AVCaptureDeviceInput(device: camera)
        }catch let error {
            print(error)
        }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        output = AVCapturePhotoOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = preView.frame
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(previewLayer)
        session.startRunning()
    }

    private func setupUI() {
        self.imageView = UIImageView(image: UIImage(named: "merry2"))
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.size.equalTo(0)
            $0.top.equalToSuperview().offset(20)
            $0.right.equalToSuperview()//.offset(-20)
        }

        self.imageView.frame.size = CGSize(width: 30, height: 30)

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.imageView.frame.origin = CGPoint(x: self.view.frame.width-200, y: 30)
                self.imageView.frame.size = CGSize(width: 200, height: 200)
            })
        }

        let image = UIImage(named: "camera_flame")
        let v = UIImageView(frame: self.view.frame)
        v.alpha = 1.0
        v.image = image
        self.view.addSubview(v)

        self.view.addSubview(restartButton)
        restartButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(45)
        }

        self.view.addSubview(gameoverLabel)
        gameoverLabel.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.equalTo(restartButton.snp.top).offset(-30)
            $0.centerX.equalTo(restartButton.snp.centerX)
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
