//
//  ShakeAnimation.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Creates a basic shake screen animation
     */
    func shakeView() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.07
        shakeAnimation.repeatCount = 3
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = CGPoint(x: self.center.x - 10, y: self.center.y)
        shakeAnimation.toValue = CGPoint(x: self.center.x + 10, y: self.center.y)
        self.layer.add(shakeAnimation, forKey: "position")
    }
}

extension UIView {
    /**
     Animates a word from the corners of the screen
     - Parameters
     -   duration: the duration of the animation
     -   rect: the frame/bound of the parent view
     -   completion: an animation completion block
     */
    func randomMovement(withDuration duration:TimeInterval, rect:CGRect, completion: @escaping (_ animated: Bool) -> ()) {
        let (minPoint, midPoint, maxPoint, cusion) = Helper.pointsForAnimation(rect: rect)
        
        self.isHidden = false
        self.center = CGPoint(x: minPoint.x, y: minPoint.y)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.25, options: .calculationModeCubicPaced, animations: {
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
