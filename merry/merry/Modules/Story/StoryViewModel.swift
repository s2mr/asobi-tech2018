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

    var choice1: PublishSubject<Chat.Choice> = PublishSubject()
    var choice2: PublishSubject<Chat.Choice> = PublishSubject()
    var choice3: PublishSubject<Chat.Choice> = PublishSubject()

    private let chatManager = ChatManager()

    func nextChat() {
        guard let c = chatManager.getNextChat() else { return }
        self.chats.append(c)

        if c.choices.count >= 3 {
            self.choice1.onNext(c.choices[0])
            self.choice2.onNext(c.choices[1])
            self.choice3.onNext(c.choices[2])
        }


		
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
