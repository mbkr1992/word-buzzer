//
//  ControlPanel.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation

class ControlPanel {
    var stateUserA: ContextMachine!
    var stateUserB: ContextMachine!
    var numberOfRounds: Int = 10
    
    var stateChanged: ((_ state: StateEnum, _ user: User?) -> ())?
    init(withUserA userA: User, userB: User) {
        stateUserA = ContextMachine(withUser: userA)
        stateUserB = ContextMachine(withUser: userB)
    }
    
    func changeStateToRoundStarted() {
        stateUserA.changeStateToRoundStarted()
        stateUserB.changeStateToRoundStarted()
        self.stateChanged?(stateUserB.state.getState(), nil)
    }
    
    func changeStateToGameEnded() {
        stateUserA.changeStateToGameEnded()
        stateUserB.changeStateToGameEnded()
        self.stateChanged?(stateUserB.state.getState(), nil)
    }
    
    func changeStateToNotAnswered() {
        stateUserA.changeStateToNotAnswered()
        stateUserB.changeStateToNotAnswered()
        self.stateChanged?(stateUserA.state.getState(), nil)
    }
    
    func changeStateToAnsweredWrong(forUser user: User) {
        if stateUserA.state.getUser() == user {
            stateUserA.changeStateToAnsweredWrong(forUser: user)
            self.stateChanged?(stateUserA.state.getState(), stateUserA.state.getUser())
        } else {
            stateUserB.changeStateToAnsweredWrong(forUser: user)
            self.stateChanged?(stateUserB.state.getState(), stateUserB.state.getUser())
        }
    }
    
    func changeStateToAnsweredRight(forUser user: User) {
        if stateUserA.state.getUser() == user {
            stateUserA.changeStateToAnsweredRight(forUser: user)
            self.stateChanged?(stateUserA.state.getState(), stateUserA.state.getUser())
        } else {
            stateUserB.changeStateToAnsweredRight(forUser: user)
            self.stateChanged?(stateUserB.state.getState(), stateUserB.state.getUser())
        }
    }
}
