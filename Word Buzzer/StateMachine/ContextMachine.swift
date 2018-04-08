//
//  File.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation

enum StateEnum {
    case gameStarted
    case gameEnded
    case roundStarted
    case userNotAnswered
    case userAnsweredWrong
    case userAnsweredRight
    
    func value(forState state: GameStateProtocol) -> StateEnum {
        if state is RoundStarted {
            return StateEnum.roundStarted
        } else if state is UserNotAnswered {
            return StateEnum.userNotAnswered
        } else if state is UserAnsweredWrong {
            return StateEnum.userAnsweredWrong
        } else if state is UserAnsweredRight {
            return StateEnum.userAnsweredRight
        } else if state is GameStarted {
            return StateEnum.gameStarted
        }
        return StateEnum.gameEnded
    }
}

protocol GameStateProtocol {
    func getMessage() -> String?
    func getUser() -> User?
    func getState() -> StateEnum
}

extension GameStateProtocol {
    func getMessage() -> String? {
        return nil
    }
    
    func getUser() -> User {
        return User(id: 0, name: "", score: Score())
    }
    
    func getState() -> StateEnum {
        return StateEnum.gameStarted
    }
}

struct GameStarted: GameStateProtocol {
    private var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func getMessage() -> String? {
        // no score update, go back to start state
        return nil
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getState() -> StateEnum {
        return StateEnum.gameStarted
    }
}

struct GameEnded: GameStateProtocol {
    private var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func getMessage() -> String? {
        // no score update, go back to start state
        return nil
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getState() -> StateEnum {
        return StateEnum.gameEnded
    }
}

struct RoundStarted: GameStateProtocol {
    private var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func getMessage() -> String? {
        // no score update, go back to start state
        return "Round started"
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getState() -> StateEnum {
        return StateEnum.roundStarted
    }
}

struct UserNotAnswered: GameStateProtocol {
    private var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func getMessage() -> String? {
        // no score update, go back to start state
        return "User passed the question."
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getState() -> StateEnum {
        return StateEnum.userNotAnswered
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
        return "\(self.user.name) answered wrongly."
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getState() -> StateEnum {
        return StateEnum.userAnsweredWrong
    }
}

struct UserAnsweredRight: GameStateProtocol {
    private var user: User!
    
    init(user: User) {
        self.user = user
        self.user.score.totalRight += 1
    }
    
    func getMessage() -> String? {
        // positive score update, go back to start state
        return "\(self.user.name) answered correctly."
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getState() -> StateEnum {
        return StateEnum.userAnsweredRight
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
    
    func changeStateToGameEnded() {
        self.localState = GameEnded(user: nil)
    }
    
    func changeStateToRoundStarted() {
        self.localState = RoundStarted(user: nil)
    }
    
    func changeStateToNotAnswered() {
        self.localState = UserNotAnswered(user: nil)
    }
    
    func changeStateToAnsweredWrong(forUser: User) {
        self.localState = UserAnsweredWrong(user: forUser)
    }
    
    func changeStateToAnsweredRight(forUser: User) {
        self.localState = UserAnsweredRight(user: forUser)
    }
}
