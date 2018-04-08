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
    
    var stateChanged: ((_ state: StateEnum, _ user: User) -> ())?
    init(withUserA userA: User, userB: User) {
        stateUserA = ContextMachine(withUser: userA)
        stateUserB = ContextMachine(withUser: userB)
    }
    
    func changeStateToRoundStarted(forUserA userA: User, userB: User) {
        stateUserA.changeStateToRoundStarted(user: userA)
        self.stateChanged?(stateUserA.state.getState(), stateUserA.state.getUser())
        
        stateUserB.changeStateToRoundStarted(user: userB)
        self.stateChanged?(stateUserB.state.getState(), stateUserB.state.getUser())
    }
    
    func changeStateToNotAnswered(forUser user: User) {
        if stateUserA.state.getUser() == user {
            stateUserA.changeStateToNotAnswered(forUser: user)
            self.stateChanged?(stateUserA.state.getState(), stateUserA.state.getUser())
        } else {
            stateUserB.changeStateToNotAnswered(forUser: user)
            self.stateChanged?(stateUserB.state.getState(), stateUserB.state.getUser())
        }
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
