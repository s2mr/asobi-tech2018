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

    var timer = Timer()
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true, block: vibrate)
        
        // Do any additional setup after loading the view.
//        timer.inval
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    
    @IBOutlet weak var callResponse: UIButton!
    
    @IBAction func response(_ sender: Any) {
        let vc = UIStoryboard(name: "MerryTalk", bundle: nil).instantiateInitialViewController()!
        
        //            present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
