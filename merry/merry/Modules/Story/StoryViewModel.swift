//
//  StoryViewModel.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation

class StoryViewModel {
	
	var talker = AVSpeechSynthesizer()

    var chats: [Chat] = [] // for present

    var choices: PublishSubject<[Chat.Choice]> = PublishSubject()

    private let chatManager = ChatManager.shared

    func nextChat() {
        guard let c = chatManager.getNextChat() else { return }
        self.chats.append(c)
        self.choices.onNext(c.choices)
		
		// audio
		if c.type == "call" {
			let utterance = AVSpeechUtterance(string:c.text)
			utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
			utterance.rate = 0.45
			utterance.pitchMultiplier = 1.5
			self.talker.speak(utterance)
			print(c.text)
		}
    }
}
