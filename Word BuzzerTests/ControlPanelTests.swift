//
//  ControlPanelTests.swift
//  Word BuzzerTests
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import XCTest

class ControlPanelTests: XCTestCase {
    var controlPanel: ControlPanel!
    var userA: User!
    var userB: User!
    
    override func setUp() {
        super.setUp()
        self.userA = User(id: 1, name: "Swift", score: Score())
        self.userB = User(id: 2, name: "ObjC", score: Score())
        self.controlPanel = ControlPanel(withUserA: self.userA, userB: self.userB)
    }
    
    override func tearDown() {
        self.controlPanel = nil
        self.userA = nil
        self.userB = nil
        super.tearDown()
    }
    
    func testStateChangedForRoundStarted() {
        self.controlPanel.stateChanged = { [weak self] (state: StateEnum, user: User) in
            switch state {
            case .roundStarted:
                if (self?.userA == user) {
                    XCTAssertTrue(self?.userA.score.totalRight == user.score.totalRight, "Round started should not effect user's state")
                    XCTAssertTrue(self?.userA.score.totalWrong == user.score.totalWrong, "Round started should not effect user's state")
                } else {
                    XCTAssertTrue(self?.userB.score.totalRight == user.score.totalRight, "Round started should not effect user's state")
                    XCTAssertTrue(self?.userB.score.totalWrong == user.score.totalWrong, "Round started should not effect user's state")
                }
                break
            default:
                XCTAssertTrue(false, "Should not have illegal state")
            }
        }
        self.controlPanel.changeStateToRoundStarted(forUserA: self.userA, userB: self.userB)
    }
    
    func testStateChangedForNotAnswered() {
        self.controlPanel.stateChanged = { [weak self] (state: StateEnum, user: User) in
            switch state {
            case .userNotAnswered:
                XCTAssertTrue(self?.userA.score.totalRight == user.score.totalRight, "No answer should not effect user's state")
                XCTAssertTrue(self?.userA.score.totalWrong == user.score.totalWrong, "No answer should not effect user's state")
                break
            default:
                XCTAssertTrue(false, "Should not have illegal state")
            }
        }
        self.controlPanel.changeStateToNotAnswered(forUser: self.userA)
    }
    
    func testStateChangedForAnsweredWrong() {
        self.controlPanel.stateChanged = { [weak self] (state: StateEnum, user: User) in
            switch state {
            case .userAnsweredWrong:
                XCTAssertTrue(self?.userA.score.totalRight == user.score.totalRight, "Wrong answer should not effect totalRight")
                XCTAssertFalse(self?.userA.score.totalWrong == user.score.totalWrong, "Wrong answer should change totalWrong")
                XCTAssertTrue(self?.userA.score.totalWrong == user.score.totalWrong - 1, "Wrong answer should increment totalWrong")
                break
            default:
                XCTAssertTrue(false, "Should not have illegal state")
            }
        }
        self.controlPanel.changeStateToAnsweredWrong(forUser: self.userA)
    }
    
    func testStateChangedForAnsweredRight() {
        self.controlPanel.stateChanged = { [weak self] (state: StateEnum, user: User) in
            switch state {
            case .userAnsweredRight:
                XCTAssertFalse(self?.userA.score.totalRight == user.score.totalRight, "Right answer should change totalRight")
                XCTAssertTrue(self?.userA.score.totalRight == user.score.totalRight - 1, "Right answer should increment total totalRight")
                XCTAssertTrue(self?.userA.score.totalWrong == user.score.totalWrong, "Right answer should not effect totalWrong")
                break
            default:
                XCTAssertTrue(false, "Should not have illegal state")
            }
        }
        self.controlPanel.changeStateToAnsweredRight(forUser: self.userA)
    }
    
}
