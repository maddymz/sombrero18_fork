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
        dst.mainView.alpha = 0
        dst.backButton.alpha = 0

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
                    src.present(dst, animated: false, completion: nil)
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

class PlayAgainSegue: UIStoryboardSegue{
    override func perform()
    {
        let src = self.source as! TriviaFinalViewController
        let dst = self.destination as! TriviaOpponentViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        UIView.animate(withDuration: 0.5, animations: {
            src.mainView.alpha = 0
            src.finalScoreLabel.alpha = 0
            src.opponentScoreLabel.alpha = 0
            src.opponentName.alpha = 0
            src.profileName.alpha = 0
            src.opponentQuote.alpha = 0
            src.profile.alpha = 0
            src.opponentAvatar.alpha = 0
            src.vsLabel.alpha = 0
            
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

class socialmediaSegue: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! HomeViewController
        let dst = self.destination as! SocialMediaViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        if self.identifier == "facebook"{
            dst.SocialMediaTitle.text = "Facebook"
            let url = URL(string: "https://facebook.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        }else if self.identifier == "twitter" {
            dst.SocialMediaTitle.text = "Twitter"
            let url = URL(string: "https://twitter.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else if self.identifier == "instagram"{
            dst.SocialMediaTitle.text = "Instagram"
            let url = URL(string: "https://instagram.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else {
            dst.SocialMediaTitle.text = "Youtube"
            let url = URL(string: "https://www.youtube.com/channel/UC2BGcbPW8mxryXnjQcBqk6A")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        }
        
        src.present(dst, animated: false, completion: nil)
    }
}

class unwinedSocialmediaSegue: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! SocialMediaViewController
        let dst = self.destination as!  LoadingViewController
        
        dst.showAnimation = false
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.present(dst, animated: false, completion: nil)
        
        
    }
}
