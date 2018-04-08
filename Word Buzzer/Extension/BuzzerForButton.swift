//
//  Buzzer.swift
//  Word Buzzer
//
//  Created by Abubakr Dar on 4/8/18.
//  Copyright © 2018 Abubakr Dar. All rights reserved.
//

import UIKit

extension UIButton {
    func activate() {
        self.isEnabled = true
        self.alpha = 1.0
    }
    
    func deactivate(alpha: CGFloat = 0.3) {
        self.isEnabled = false
        self.alpha = alpha
    }
}
