//
//  ContextMachineTests.swift
//  Word BuzzerTests
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import XCTest

class ContextMachineTests: XCTestCase {
    var context: ContextMachine!
    override func setUp() {
        super.setUp()
        let user = User(id: 1, name: "Swift", score: Score())
        self.context = ContextMachine(withUser: user)
    }
    
    override func tearDown() {
        self.context = nil
        super.tearDown()
    }
    
    func testChangeToUserNotAnswered() {
        let user = User(id: 1, name: "Swift", score: Score(totalRight: 1, totalWrong: 2))
        self.context.changeStateToNotAnswered(forUser: user)
        XCTAssertTrue(self.context.state.getUser().score == Score(totalRight: 1, totalWrong: 2), "Should not change the score")
        XCTAssertTrue(self.context.state.getMessage() == nil)
    }
    
    func testChangeToUserAnsweredRight() {
        let user = User(id:1, name: "Swift", score: Score(totalRight: 1, totalWrong: 2))
        self.context.changeStateToAnsweredRight(forUser: user)
        XCTAssertTrue(self.context.state.getUser().score == Score(totalRight: 2, totalWrong: 2), "total right answers should be incremented")
        XCTAssertTrue(self.context.state.getMessage() == nil)
    }
    
    func testChangeToUserAnsweredWrong() {
        let user = User(id:1, name: "Swift", score: Score(totalRight: 1, totalWrong: 2))
        self.context.changeStateToAnsweredWrong(forUser: user)
        XCTAssertTrue(self.context.state.getUser().score == Score(totalRight: 1, totalWrong: 3), "total wrong answers should be incremented")
        XCTAssertTrue(self.context.state.getMessage() == nil)
    }
    
}
