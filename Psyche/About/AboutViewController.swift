//
//  AboutViewController.swift
//  Psyche
//
//  Created by psyche-admin on 6/21/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var devOne: UILabel!
    @IBOutlet weak var devTwo: UILabel!
    @IBOutlet weak var devThree: UILabel!
    @IBOutlet weak var devFour: UILabel!
 
    @IBOutlet weak var devOneY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        layout()
        animateContent()
        
    }
    
    func layout() {
        self.devOne.frame = CGRect(x: 163, y: 550, width: 42, height: 21)
        self.devTwo.frame = CGRect(x: 163, y: 580, width: 42, height: 21)
        self.devThree.frame = CGRect(x: 163, y: 610, width: 42, height: 21)
        self.devFour.frame = CGRect(x: 163, y: 640, width: 42, height: 21)
        

    }
    func animateContent () {
        UIView.animate(
            withDuration: 5,
            delay: 0,
            options: .repeat, animations: {
                self.devOne.frame = CGRect(x: 163, y: 50, width: 42, height: 21)
                self.devTwo.frame = CGRect(x: 163, y: 100, width: 42, height: 21)
                self.devThree.frame = CGRect(x: 163, y: 150, width: 42, height: 21)
                self.devFour.frame = CGRect(x: 163, y: 170, width: 42, height: 21)
                self.devTwo.isHidden = true
                self.devThree.isHidden = true
                self.devFour.isHidden = true

                

        }, completion: {
            (value: Bool) in
            self.devOne.isHidden = true
            self.devTwo.isHidden = true
            self.devThree.isHidden = true
            self.devFour.isHidden = true
            
        })
    }
    
//
//    func layoutConstraints() {
//
//    }
    
}
