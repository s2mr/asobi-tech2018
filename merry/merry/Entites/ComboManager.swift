//
//  ComboManager.swift
//  merry
//
//  Created by 大川恭平 on 2018/02/28.
//  Copyright © 2018年 kazu. All rights reserved.
//

import Foundation
import UIKit

class ComboManager {
    
    private var images: [UIImage] = []
    private var nextId = 0
    
    init() {
        for i in 0..<9 {
            if let image = UIImage(named: "combo_\(i)") {
                images.append(image)
            }
        }
    }
    
    public func getNextComboImage() -> UIImage? {
        nextId += 1
        if nextId <= images.count{
            return images[nextId-1]
        }
        
        return nil
    }
    
    public func endCombo(){
        nextId = 0
    }
}
