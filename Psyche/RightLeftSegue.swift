//
//  RightLeftSegue.swift
//  Psyche
//
//  Created by Julia Liu on 4/10/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit

class RightLeftSegue : UIStoryboardSegue{
    
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
            completion: { finished in
                src.present(dst, animated: false, completion: nil)
            }
        )
    }
}

class UnwindRightLeftSegue : UIStoryboardSegue{
    
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)

        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        },
            completion: { finished in
                src.dismiss(animated: false, completion: nil)
            }
        )
    }
    
}
