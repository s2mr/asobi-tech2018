//
//  ClearViewController.swift
//  merry
//
//  Created by 大川恭平 on 2018/02/28.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit

class ClearViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var storySelectButton: UIButton!

    var parentVC: UIViewController?
    
    public var displayScore:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storySelectButton.layer.cornerRadius = 8
        storySelectButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scoreLabel.text = "Score:" + String(displayScore)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonTouchUp(_ sender: Any) {
        dismiss(animated: false, completion: { [weak self] in
            self?.parentVC?.navigationController?.popToRootViewController(animated: true)
        })
    }
}
