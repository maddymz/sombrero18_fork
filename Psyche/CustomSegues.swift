//
//  CustomSegues.swift
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

class ProfileOpponentSegue : UIStoryboardSegue{
    
    override func perform()
    {
        let src = self.source as! TriviaProfileViewController
        let dst = self.destination as! TriviaOpponentViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        UIView.animate(withDuration: 0.5, animations: {
            src.mainView.alpha = 0
            src.backButton.alpha = 0
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                src.view.alpha = 0
            }, completion: { finished in
                UIView.animate(withDuration: 1, animations: {
                    dst.gradient.frame = CGRect(x:0, y:0, width: dst.view.frame.width, height: 130)
                }, completion: { finished in
                    src.present(dst, animated: false, completion: nil)
                })
            })
        })
    }
}

class UnwindProfileOpponentSegue: UIStoryboardSegue{
    override func perform(){
        let dst = self.destination as! TriviaProfileViewController
        let src = self.source as! TriviaOpponentViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        dst.view.alpha = 1

        UIView.animate(withDuration: 0.5, animations: {
            src.gradient.frame = CGRect(x:0, y:0, width: src.view.frame.width, height: src.view.frame.height)
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                src.view.alpha = 0
            }, completion: { finished in
                UIView.animate(withDuration: 0.5, animations: {
                    dst.backButton.alpha = 1
                    dst.mainView.alpha = 1
                }, completion: { finished in
                    src.dismiss(animated: false, completion: nil)
                })
            })
        })
    }
}

class GameFinalSegue: UIStoryboardSegue{
    override func perform()
    {
        let src = self.source as! TriviaGameViewController
        let dst = self.destination as! TriviaFinalViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)

        UIView.animate(withDuration: 1, animations: {
            src.gradient.frame = CGRect(x:0, y:0, width: src.view.frame.width, height: src.view.frame.height)
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                src.view.alpha = 0
            }, completion: { finished in
                src.present(dst, animated: false, completion: nil)
            })
        })
    }
}
