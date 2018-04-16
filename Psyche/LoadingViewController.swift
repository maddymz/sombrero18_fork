//
//  LoadingViewController.swift
//  Psyche
//
//  Created by Julia Liu on 3/14/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit

class LoadingViewController: UITabBarController {

    @IBOutlet var View1: UIView!
    @IBOutlet var View2: UIView!
    @IBOutlet var View3: UIView!
    @IBOutlet var View4: UIView!
    @IBOutlet var View5: UIView!
    @IBOutlet var View6: UIView!

    
    public var showAnimation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if showAnimation {
            showLoadingScreen()
        }
    }
  
    func showLoadingScreen(){
        //Add loading subviews to the main view
        View1.frame.size.width = view.frame.width
        View1.frame.size.height = view.frame.height
        View1.alpha = 1
        view.addSubview(View1)
        View2.frame.size.width = view.frame.width
        View2.frame.size.height = view.frame.height
        View2.alpha = 0
        view.addSubview(View2)
        View3.frame.size.width = view.frame.width
        View3.frame.size.height = view.frame.height
        View3.alpha = 0
        view.addSubview(View3)
        View4.frame.size.width = view.frame.width
        View4.frame.size.height = view.frame.height
        View4.alpha = 0
        view.addSubview(View4)
        View5.frame.size.width = view.frame.width
        View5.frame.size.height = view.frame.height
        View5.alpha = 0
        view.addSubview(View5)
        View6.frame.size.width = view.frame.width
        View6.frame.size.height = view.frame.height
        View6.alpha = 0
        view.addSubview(View6)
        
        //time for each part of the logo to fade
        let duration = 0.5;
        
        //animations
        UIView.animate(withDuration: duration, animations: {
            self.View2.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: duration, animations: {
                self.View3.alpha = 1
            }) { (success) in
                UIView.animate(withDuration: duration, animations: {
                    self.View4.alpha = 1
                }) { (success) in
                    UIView.animate(withDuration: duration, animations: {
                        self.View5.alpha = 1
                    }) { (success) in
                        UIView.animate(withDuration: duration, animations: {
                            self.View6.alpha = 1
                        }) { (success) in
                            UIView.animate(withDuration: 1.5, animations: {
                                self.View1.removeFromSuperview()
                                self.View2.removeFromSuperview()
                                self.View3.removeFromSuperview()
                                self.View4.removeFromSuperview()
                                self.View5.removeFromSuperview()
                                
                                //shrinks the view
                                self.View6.frame = CGRect(x:0, y:0, width: self.view.frame.width, height:130)

                            }) { (success) in
                                UIView.animate(withDuration: 0.5, animations: {
                                    
                                    self.View6.alpha = 0;
                                    
                                }) { (success) in
                                    self.View6.removeFromSuperview()
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
}
