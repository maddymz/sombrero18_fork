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
            dst.socialMediaTitle.text = "Facebook"
            let url = URL(string: "https://facebook.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        }else if self.identifier == "twitter" {
            dst.socialMediaTitle.text = "Twitter"
            let url = URL(string: "https://twitter.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else if self.identifier == "instagram"{
            dst.socialMediaTitle.text = "Instagram"
            let url = URL(string: "https://instagram.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else {
            dst.socialMediaTitle.text = "Youtube"
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
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.dismiss(animated: false, completion: nil)
    }
}

class socialmediaSegueTimeline: UIStoryboardSegue {
    override func perform() {
        
        let src = self.source as! TimelineTableViewController
        let dst = self.destination as! SocialMediaTimelineViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        if self.identifier == "facebook"{
            dst.socialMediaTitle.text = "Facebook"
            let url = URL(string: "https://facebook.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        }else if self.identifier == "twitter" {
            dst.socialMediaTitle.text = "Twitter"
            let url = URL(string: "https://twitter.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else if self.identifier == "instagram"{
            dst.socialMediaTitle.text = "Instagram"
            let url = URL(string: "https://instagram.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else {
            dst.socialMediaTitle.text = "Youtube"
            let url = URL(string: "https://www.youtube.com/channel/UC2BGcbPW8mxryXnjQcBqk6A")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        }
        
        src.present(dst, animated: false, completion: nil)
    }
}

class unwinedSocialmediaSegueTimeline: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! SocialMediaTimelineViewController
        let dst = self.destination as!  TimelineTableViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.dismiss(animated: false, completion: nil)
    }
}


class socialmediaSegueGallery: UIStoryboardSegue {
    override func perform() {
        
        let src = self.source as! GalleryViewController
        let dst = self.destination as! SocialMediaGalleryViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        if self.identifier == "facebook"{
            dst.socialMediaTitle.text = "Facebook"
            let url = URL(string: "https://facebook.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        }else if self.identifier == "twitter" {
            dst.socialMediaTitle.text = "Twitter"
            let url = URL(string: "https://twitter.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else if self.identifier == "instagram"{
            dst.socialMediaTitle.text = "Instagram"
            let url = URL(string: "https://instagram.com/nasapsyche")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        } else {
            dst.socialMediaTitle.text = "Youtube"
            let url = URL(string: "https://www.youtube.com/channel/UC2BGcbPW8mxryXnjQcBqk6A")!
            let reqObj = URLRequest(url: url)
            dst.wbView.load(reqObj)
        }
        
        src.present(dst, animated: false, completion: nil)
    }
}

class unwinedSocialmediaSegueGallery: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! SocialMediaGalleryViewController
        let dst = self.destination as!  GalleryViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.dismiss(animated: false, completion: nil)
    }
}

class AboutScreenSegue: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! HomeViewController
        let dst = self.destination as! AboutViewController
        
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
         src.present(dst, animated: false, completion: nil)
    }
}

class unwinedAboutScreenSegue: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! AboutViewController
        let dst = self.destination as!  LoadingViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.dismiss(animated: false, completion: nil)
    }
}

class AboutScreenSegueTimeline: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! TimelineTableViewController
        let dst = self.destination as! AboutViewController
        
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.present(dst, animated: false, completion: nil)
    }
}

class unwinedAboutScreenSegueTimeline: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! AboutViewController
        let dst = self.destination as!  TimelineTableViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.dismiss(animated: false, completion: nil)
    }
}

class AboutScreenSegueGallery: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! GalleryViewController
        let dst = self.destination as! AboutViewController
        
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.present(dst, animated: false, completion: nil)
    }
}

class unwinedAboutScreenSegueGallery: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! AboutViewController
        let dst = self.destination as!  GalleryViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.dismiss(animated: false, completion: nil)
    }
}
