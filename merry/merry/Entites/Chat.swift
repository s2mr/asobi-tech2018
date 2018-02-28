//
//  Chat.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import Foundation
import Unbox

struct Chat: Unboxable {

    struct Choice: Unboxable {
        let score: Int
        let text: String
        let nextId: Int

        init(unboxer: Unboxer) throws {
            score = try unboxer.unbox(key: "score")
            text = try unboxer.unbox(key: "text")
            nextId = try unboxer.unbox(key: "nextId")
        }
    }

    enum Owner {
        case `self`
        case other
    }

    let id: Int
    let text: String
	let type: String
    let choices: [Choice]
    let owner: Owner

    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        text = try unboxer.unbox(key: "text")
		type = try unboxer.unbox(key: "type")
        choices = try unboxer.unbox(key: "choices")
        owner = .other
    }

    init(_ c: Choice) {
        id = -1
        text = c.text
        type = ""
        choices = []
        owner = .self
    }
}
