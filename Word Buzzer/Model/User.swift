//
//  User.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation

struct Score: Equatable {
    var totalRight: Int
    var totalWrong: Int
    
    init(totalRight: Int = 0, totalWrong: Int = 0) {
        self.totalRight = totalRight
        self.totalWrong = totalWrong
    }
    
    static func == (lhs: Score, rhs: Score) -> Bool {
        return lhs.totalRight == rhs.totalRight && lhs.totalWrong == rhs.totalWrong
    }
}

struct User {
    var name: String
    var score: Score
}


