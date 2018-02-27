//
//  CallViewController.swift
//  merry
//
//  Created by 大川恭平 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit
import AudioToolbox

class CallViewController: UIViewController {

    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true, block: vibrate)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func vibrate(timer: Timer) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
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
