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

    enum State {
        case normal
        case calling(chat: Chat)
        case clear
        case gameover
    }

    var talker = AVSpeechSynthesizer()

    var chats: [Chat] = [] // for present
    let choice1: PublishSubject<Chat.Choice> = PublishSubject()
    let choice2: PublishSubject<Chat.Choice> = PublishSubject()
    let choice3: PublishSubject<Chat.Choice> = PublishSubject()
    let state: PublishSubject<State> = PublishSubject()
    let shouldShowFooter: PublishSubject<Bool> = PublishSubject()
    let disposeBag = DisposeBag()

    var totalScore: Variable<Int> = Variable(0)

    private let chatManager = ChatManager()

    init() {
        totalScore.asObservable().subscribe(onNext: { [weak self] (score) in
            if score > 5 {
                self?.state.onNext(.clear)
            }
        }).disposed(by: disposeBag)
        
    }

    func nextChat(nextId: Int? = nil) {
        guard let c = chatManager.getNextChat(id: nextId) else { return }

        switch c.type {
        case .text:
            state.onNext(.normal)
        case .call:
            state.onNext(.calling(chat: c))
        case .fin:
            state.onNext(.gameover)
        }

        self.chats.append(c)

        if c.choices.count >= 3 {
            shouldShowFooter.onNext(true)
            self.choice1.onNext(c.choices[0])
            self.choice2.onNext(c.choices[1])
            self.choice3.onNext(c.choices[2])
        } else {
            shouldShowFooter.onNext(false)
        }

        // audio
//        if c.type == "call" {
//            let utterance = AVSpeechUtterance(string:c.text)
//            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
//            utterance.rate = 0.45
//            utterance.pitchMultiplier = 1.5
//            self.talker.speak(utterance)
//            print(c.text)
//        }
    }

    func appendChoiceIntoChats(_ c: Chat.Choice) {
        totalScore.value += c.score
        let chat = Chat(c)
        chats.append(chat)
    }
}
