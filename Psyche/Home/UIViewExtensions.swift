//
//  UIViewExtensions.swift
//  Psyche
//
//  Created by Rivinis on 2/15/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func fadeIn(duration: TimeInterval, delay: TimeInterval, completion: ((_ finished: Bool) -> Void)?) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: { self.alpha = 1.0 }, completion: completion)
    }

    func fadeInTwo(duration: TimeInterval, delay: TimeInterval, completion: ((_ finished: Bool) -> Void)?) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: { self.alpha = 0.5 }, completion: completion)
    }
    
}
