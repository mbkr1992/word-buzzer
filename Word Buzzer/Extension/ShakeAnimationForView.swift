//
//  ShakeAnimation.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

extension UIView {
    func randomMovement(rect:CGRect, completion: @escaping (_ animated: Bool) -> ()) {
        let (minPoint, midPoint, maxPoint, cusion) = pointsForAnimation(rect: rect)
        
        self.isHidden = false
        self.center = CGPoint(x: minPoint.x, y: minPoint.y)
        
        UIView.animateKeyframes(withDuration: 4.0, delay: 0.25, options: .calculationModeCubicPaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.center = midPoint
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 3, animations: {
                self.center = CGPoint(x: midPoint.x, y: midPoint.y + cusion )
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2.5, relativeDuration: 0.5, animations: {
                self.center = maxPoint
            })
        }) { (animated: Bool) in
            self.isHidden = true
            completion(animated)
        }
    }
}

private func pointsForAnimation(rect: CGRect) -> (minPoint: CGPoint, midPoint: CGPoint, maxPoint: CGPoint, cusioin: CGFloat) {
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
        cusion = 200.0
        maxY = rect.maxY
    } else { // bottom to top
        minY = rect.maxY
        cusion = -200.0
        maxY = rect.minY
    }
    
    let minPoint = CGPoint(x: minX, y: minY)
    let midPoint = CGPoint(x: rect.midX, y: rect.midY)
    let maxPoint = CGPoint(x: maxX, y: maxY)
    
    return (minPoint, midPoint, maxPoint, cusion)
}
