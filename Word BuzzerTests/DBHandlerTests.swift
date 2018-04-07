//
//  DBHandlerTest.swift
//  Word BuzzerTests
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import XCTest

class DBHandlerTest: XCTestCase {
    var dbHandler: DBHandler!
    
    override func setUp() {
        super.setUp()
        self.dbHandler = DBHandler()
    }
    
    override func tearDown() {
        self.dbHandler = nil
        super.tearDown()
    }
    
    func testWordsFileIsNonEmpty() {
        let result = self.dbHandler.getContentFor(filename: "words", ofType: "json")
        XCTAssertFalse(result.isEmpty, "words file should not be empty")
    }
}
