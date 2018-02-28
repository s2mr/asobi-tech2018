//
//  StoryFooterView.swift
//  merry
//
//  Created by 下村一将 on 2018/02/28.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit

@IBDesignable
class StoryFooterView: UIView {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }

    override func prepareForInterfaceBuilder() {
        loadXib()
    }

    private func loadXib() {
        self.backgroundColor = .clear
    
        let view = UINib(nibName: "StoryFooterView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        self.addSubview(view)

        let buttons = [button1,button2,button3]
        for b in buttons {
            b?.layer.cornerRadius = 8
            b?.tintColor = .white
            b?.backgroundColor = .black
            b?.alpha = 0.6
        }
    }

    func setTitle(a: String, b: String, c: String) {
        button1.setTitle(a, for: .normal)
        button2.setTitle(b, for: .normal)
        button3.setTitle(c, for: .normal)
    }
}
