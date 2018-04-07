//
//  File.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation

protocol GameStateProtocol {
    func updateState(state: GameState) // no user pressed the buzzer
    func performAction()
}

extension GameStateProtocol {
    func updateState(state: GameState) {
        state.setState(state: self)
        // Default empty implementation
    }
    
    func performAction() {
        // Default empty implementation
    }
}

struct NoUserAnswered: GameStateProtocol {
    func updateState(state: GameState) {
        state.setState(state: self)
    }
    
    func performAction() {
        // no score update, go back to start state
    }
}

class UserAnsweredWrong: GameStateProtocol {
    func updateState(state: GameState) {
        state.setState(state: self)
    }
    
    func performAction() {
        // negative score update, go back to start state
    }
}

class UserAnswerRight: GameStateProtocol {
    func updateState(state: GameState) {
        state.setState(state: self)
    }
    
    func performAction() {
        // positive score update, go back to start state
    }
}

class GameState {
    private var localState: GameStateProtocol!
    
    var state : GameStateProtocol {
        return localState
    }
    
    func setState(state: GameStateProtocol) {
        self.localState = state
    }
}
