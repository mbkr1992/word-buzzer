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
        self.transform = CGAffineTransform(translationX: rect.maxX, y: rect.maxY)
        UIView.animate(withDuration: 2.0, delay: 0.25, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.transform = CGAffineTransform(translationX: rect.minX, y: rect.minY)
        }) { (animated: Bool) in
            completion(animated)
        }
    }
}
