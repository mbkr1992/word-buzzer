//
//  File.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation

protocol GameStateProtocol {
    func getMessage() -> String?
    func getScore() -> Score
}

extension GameStateProtocol {
    func getMessage() -> String? {
        return nil
    }
    
    func getScore() -> Score {
        return Score(totalRight: 0, totalWrong: 0)
    }
}

struct GameStarted: GameStateProtocol {
    private var user: User!
    
    init(user: User) {
        self.user = user
    }
    
    func getMessage() -> String? {
        // no score update, go back to start state
        return nil
    }
    
    func getScore() -> Score {
        return self.user.score
    }
}

struct UserNotAnswered: GameStateProtocol {
    private var user: User!
    
    init(user: User) {
        self.user = user
    }
    
    func getMessage() -> String? {
        // no score update, go back to start state
        return nil
    }
    
    func getScore() -> Score {
        return self.user.score
    }
}

struct UserAnsweredWrong: GameStateProtocol {
    private var user: User!
    
    init(user: User) {
        self.user = user
        self.user.score.totalWrong += 1
    }
    
    func getMessage() -> String? {
        // negative score update, go back to start state
        return nil
    }
    
    func getScore() -> Score {
        return self.user.score
    }
}

struct UserAnswerRight: GameStateProtocol {
    private var user: User!
    
    init(user: User) {
        self.user = user
        self.user.score.totalRight += 1
    }
    
    func getMessage() -> String? {
        // positive score update, go back to start state
        return nil
    }
    
    func getScore() -> Score {
        return self.user.score
    }
}

class ContextMachine {
    private var localState: GameStateProtocol!
    
    init(withUser user: User) {
        localState = GameStarted(user: user)
    }
    
    var state : GameStateProtocol {
        return localState
    }
    
    func changeStateToUserNotAnswered(user: User) {
        self.localState = UserNotAnswered(user: user)
    }
    
    func changeStateToUserAnsweredWrong(user: User) {
        self.localState = UserAnsweredWrong(user: user)
    }
    
    func changeStateToUserAnswerRight(user: User) {
        self.localState = UserAnswerRight(user: user)
    }
}
