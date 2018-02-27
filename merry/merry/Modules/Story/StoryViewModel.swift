//
//  StoryViewModel.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import Foundation
import RxSwift

class StoryViewModel {

    var chats: [Chat] = [] // for present

    private let chatManager = ChatManager.shared

    func nextChat() {
        if let c = chatManager.getNextChat() {
            self.chats.append(c)
        }
    }
}
