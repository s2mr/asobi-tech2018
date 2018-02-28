//
//  CallViewCell.swift
//  merry
//
//  Created by 戸羽俊介 on 2018/02/28.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit

class CallViewCell: UITableViewCell {

	@IBOutlet weak var callIcon: UIImageView!
	@IBOutlet weak var callText: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.backgroundColor = .clear
		self.layer.cornerRadius = 8
		self.layer.masksToBounds = true
    }
}
