//
//  Helper.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/9/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    static func isGameOver(rounds: Int, round: Int) -> Bool {
        return rounds == round
    }
    
    static func checkAnswer(wordOne: Dictionary<String, String>, wordTwo: Dictionary<String, String>) -> Bool {
        return wordOne["text_eng"] == wordTwo["text_eng"]
    }
    
    
    /**
     Each time generates random points for the label animation
     - Returns: A tuple where first item is the next item, and second item is the randomized array
     - Parameters
        -   minPoint: the starting point
        -   midPoint: the middle point
        -   maxPoint: the ending point
        -   cusion: moving straight distance
     */
    static func pointsForAnimation(rect: CGRect) -> (minPoint: CGPoint, midPoint: CGPoint, maxPoint: CGPoint, cusioin: CGFloat) {
        let leftOrRight = Int(arc4random_uniform(UInt32(2)))
        let topOrBottom = Int(arc4random_uniform(UInt32(2)))
        var cusion = CGFloat()
        var (minX, minY, maxX, maxY) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        if leftOrRight == 0 { // Left to right
            minX = rect.minX
            maxX = rect.maxX
        } else { // right to left
            minX = rect.maxX
            maxX = rect.minX
        }
        
        if topOrBottom == 0 { // Top to bottom
            minY = rect.minY
            cusion = 100.0
            maxY = rect.maxY
        } else { // bottom to top
            minY = rect.maxY
            cusion = -100.0
            maxY = rect.minY
        }
        
        let minPoint = CGPoint(x: minX, y: minY)
        let midPoint = CGPoint(x: rect.midX, y: rect.midY)
        let maxPoint = CGPoint(x: maxX, y: maxY)
        
        return (minPoint, midPoint, maxPoint, cusion)
    }

}


