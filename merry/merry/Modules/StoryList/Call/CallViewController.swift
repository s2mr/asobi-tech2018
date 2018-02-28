//
//  CallViewController.swift
//  merry
//
//  Created by 大川恭平 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import RxSwift

class CallViewController: UIViewController {
    var talker = AVSpeechSynthesizer()
    
    var timer = Timer()
    
    var audioPlayer = AVAudioPlayer()

    let disposeBag = DisposeBag()
    
    public var talkString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .blue
        button.setTitle("X", for: .normal)
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        }).disposed(by: disposeBag)
        self.view.addSubview(button)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        audioPlayer.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true, block: vibrate)
        
        self.talker.delegate = self
        
        do{
            let filePath = Bundle.main.path(forResource: "ring", ofType: "mp3")
            let audioPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: audioPath)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch{
            print("error play ring sound")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func vibrate(timer: Timer) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    public func playVoice(fileName:String,type:String){
        do{
            let filePath = Bundle.main.path(forResource: fileName, ofType: type)
            let audioPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: audioPath)
            audioPlayer.delegate = self
            audioPlayer.numberOfLoops = 0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch{
            print("error play merry voice")
        }
    }
    
    @IBOutlet weak var callResponse: UIButton!
    
    @IBOutlet weak var talkNow: UILabel!
    
    @IBAction func response(_ sender: Any) {
        callResponse.isHidden = true
        talkNow.isHidden = false
        timer.invalidate()
        audioPlayer.stop()
        //playVoice(fileName: "why", type: "mp3")
        talkString(talkText: talkString)
    }
    
    func talkString(talkText: String)
    {
        let utterance = AVSpeechUtterance(string:talkText)
        utterance.voice = AVSpeechSynthesisVoice(language:"ja-JP")
        utterance.rate = 0.45
        utterance.pitchMultiplier = 1.5
        self.talker.speak(utterance)
    }
}

extension CallViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CallViewController : AVSpeechSynthesizerDelegate{
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.dismiss(animated: false, completion: nil)
    }
}

