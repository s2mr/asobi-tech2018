//
//  ChatManager.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import Foundation
import Unbox

class ChatManager {

    private var chats: [Chat] = []
    private var nextId = 1

    init() {
        guard let path = Bundle.main.path(forResource: "StubChatText", ofType: "json"), let fileHandle = FileHandle(forReadingAtPath: path) else { return }
        let data = fileHandle.readDataToEndOfFile()
        self.chats = try! unbox(data: data, atKeyPath: "chatText", allowInvalidElements: true)
    }

    func getNextChat(id: Int? = nil) -> Chat? {
        if id == nil {
            //next
            for c in self.chats {
                if c.id == nextId {
                    nextId += 1
                    return c
                }
            }
        } else {
            return getChat(by: id)
        }

        return nil
    }

    private func getChat(by id: Int?) -> Chat? {
        guard let id = id else { return nil }
        for c in self.chats {
            if c.id == id {
                return c
            }
        }
        return nil
    }
}
