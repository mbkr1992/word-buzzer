//
//  RandomObjectArray.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation

extension Array {
    
    /**
     Generate a random object from array
     - Returns: A randomly generated object if exists, nil otherwise
     */
    func randomObject() -> Element? {
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        return self.isEmpty ? nil : self[randomIndex]
    }
}
