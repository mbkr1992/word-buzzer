//
//  WordGeneratorTests.swift
//  Word BuzzerTests
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import XCTest

class WordGeneratorTests: XCTestCase {
    var wordGenerator: WordGenerator!
    var limit: Int! = 5
    
    override func setUp() {
        super.setUp()
        let words = DBHandler().getContentFor(filename: "words", ofType: "json")
        self.wordGenerator = WordGenerator(withWords: words, limit: self.limit)
    }
    
    override func tearDown() {
        self.wordGenerator = nil
        super.tearDown()
    }
    
    func testWordGeneratorIsNonEmpty() {
        XCTAssertFalse(self.wordGenerator.words.isEmpty, "Words can not be empty.")
    }
    
    func testWrongWordsAreCorrect() {
        let range: ClosedRange = 0...2
        let selectedWords = self.wordGenerator.wrongWords(range: range)
        guard let words = selectedWords else {
            XCTAssertTrue(false, "Optional should not be nil")
            return
        }
        
        XCTAssertTrue(words.count == range.count)
        XCTAssertTrue(words[0] == self.wordGenerator.words[0])
        XCTAssertTrue(words[1] == self.wordGenerator.words[1])
        XCTAssertTrue(words[2] == self.wordGenerator.words[2])
    }
    
    func testNextWhenFirstValue() {
        guard let (word, collection) = self.wordGenerator.next() else {
            XCTAssertTrue(false, "Optional should not be nil")
            return
        }
        XCTAssertTrue(word == self.wordGenerator.words[0])
        XCTAssertTrue(collection.count == self.limit)
        XCTAssertTrue(collection.contains(word))
    }
    
    func testNextWhenLimitExceedsCurrent() {
        // This loop iterates to a point where afterwards 2nd condition in the next function will trigger
        for _ in 0...(self.wordGenerator.words.count - self.limit - 1) {
            _ = self.wordGenerator.next()
        }
        
        if let (word, collection) = self.wordGenerator.next() {
            XCTAssertTrue(collection.count == self.limit)
            XCTAssertTrue(collection.contains(word))
            
            if let (word1, collection1) = self.wordGenerator.next() {
                XCTAssertTrue(collection1.count == self.limit)
                XCTAssertTrue(collection1.contains(word1))
                XCTAssertTrue(collection1 == collection)
                XCTAssertTrue(word1 != word)
            } else {
                XCTAssertTrue(false, "Optional should not be nil")
            }
        } else {
            XCTAssertTrue(false, "Optional should not be nil")
        }
    }
}
