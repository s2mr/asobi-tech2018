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

class CallViewController: UIViewController {
    let viewModel = StoryViewModel()
    
    var timer = Timer()
    
    var audioPlayer = AVAudioPlayer()
    
    public var talkString = "私今あなたのそばにいるの"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        timer.inval
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
        audioPlayer.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true, block: vibrate)
        
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
    
    @IBAction func response(_ sender: Any) {
        callResponse.isHidden = true
        timer.invalidate()
        audioPlayer.stop()
        //playVoice(fileName: "why", type: "mp3")
        viewModel.talkString(talkText: talkString)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CallViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
