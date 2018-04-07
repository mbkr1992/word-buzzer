//
//  File.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/7/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation

class WordGenerator {
    private var current: Int!
    private var limit: Int!
    
    typealias BabbelWord = Dictionary<String, String>
    var words: Array<BabbelWord>!
    init(withWords words: Array<BabbelWord>, limit: Int) {
        self.words = words
        self.current = 0
        self.limit = limit
    }
    
    func next() -> (BabbelWord, Array<BabbelWord>)? {
        print("next: \(self.current!)")
        var result: (BabbelWord, Array<BabbelWord>)?
        if self.words.count == self.current {
            return nil
        }
        
        if self.current == 0 {
            result = (self.words[self.current], self.wrongWords(range: 0...self.limit - 1)!)
        } else if (self.words.count - self.current <= self.limit) {
            result = (self.words[self.current], self.wrongWords(range: (self.words.count - self.limit)...self.words.count - 1)!)
        } else {
            result = (self.words[self.current], self.wrongWords(range: self.current...(self.current + (self.limit - 1)))!)
        }
        self.current = self.current + 1
        return result
    }
    
    func reset() {
        self.current = 0
    }
    
    func wrongWords(range: ClosedRange<Int>) -> Array<BabbelWord>? {
        let selectedWords = self.words[range]
        return Array(selectedWords)
    }
}
