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
    
    @IBOutlet weak var devFive: UILabel!
    
    @IBOutlet weak var devSix: UILabel!
    
    @IBOutlet weak var devSeven: UILabel!
    
    
    @IBOutlet weak var devEight: UILabel!
    
    
    @IBOutlet weak var bckView: UIImageView!
    @IBOutlet weak var devNine: UILabel!
    @IBOutlet weak var srDevLabel: UILabel!
    
    @IBOutlet weak var devLabel: UILabel!
    @IBOutlet weak var graphicDesignlabel: UILabel!
    @IBOutlet weak var prManagerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()       
        layout()
        animateContent()
        
    }
    
    func layout() {
        
        self.devOne.alpha = 0.0
        self.devTwo.alpha = 0.0
        self.devThree.alpha = 0.0
        self.devFour.alpha = 0.0
        self.devFive.alpha = 0.0
        self.devSix.alpha = 0.0
        self.devSeven.alpha = 0.0
        self.devEight.alpha = 0.0
        self.devNine.alpha = 0.0
        self.srDevLabel.alpha = 0.0
        self.prManagerLabel.alpha = 0.0
        self.graphicDesignlabel.alpha = 0.0
        self.devLabel.alpha = 0.0
        
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            self.srDevLabel.frame = CGRect(x: 120.26, y: 550, width: 132, height: 21)
            self.prManagerLabel.frame = CGRect(x: 124.08, y: 550, width: 126, height: 21)
            self.graphicDesignlabel.frame = CGRect(x: 116.43, y: 550, width: 142, height: 21)
            self.devLabel.frame = CGRect(x: 143.18, y: 550, width: 87, height: 21)
            
            self.devOne.frame = CGRect(x: 124, y: 550, width: 125, height: 21)
            self.devTwo.frame = CGRect(x: 142, y: 550, width: 89, height: 21)
            self.devThree.frame = CGRect(x: 150.83, y: 550, width: 72, height: 21)
            self.devFour.frame = CGRect(x: 156, y: 550, width: 62, height: 21)
            self.devFive.frame = CGRect(x: 140, y: 550, width: 94, height: 21)
            self.devSix.frame = CGRect(x: 117, y: 550, width: 139, height: 21)
            self.devSeven.frame = CGRect(x: 134.27, y: 550, width: 105, height: 21)
            self.devEight.frame = CGRect(x: 119.5, y: 550, width: 135, height: 21)
            self.devNine.frame = CGRect(x: 140, y: 550, width: 94, height: 21)
            
        } else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
            
        }else if UIDevice.current.screenType == .iPhone_XSMax {
            
        }else if UIDevice.current.screenType == .iPhone_XR {
            
        }else if UIDevice.current.screenType == .iPhones_X_XS {
            
        }else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            
        }
        
        
        

    }
    func animateContent () {
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 0,
            animations: {
                self.srDevLabel.alpha = 1.0
                self.srDevLabel.frame = self.srDevLabel.frame.offsetBy(dx: 0, dy: -444)
        },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 1.2,
            animations: {
                self.prManagerLabel.alpha = 1.0
                self.prManagerLabel.frame = self.prManagerLabel.frame.offsetBy(dx: 0, dy: -369)
        },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 2.4,
            animations: {
                self.graphicDesignlabel.alpha = 1.0
                self.graphicDesignlabel.frame = self.graphicDesignlabel.frame.offsetBy(dx: 0, dy: -294)
        }, completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 4.0,
            animations: {
                self.devLabel.alpha = 1.0
                self.devLabel.frame = self.devLabel.frame.offsetBy(dx: 0, dy: -189)
        },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 4.6,
            animations: {
                self.devOne.alpha = 1.0
                self.devOne.frame = self.devOne.frame.offsetBy(dx: 0, dy: -149)
                },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 5.2,
            animations: {
                self.devTwo.alpha = 1.0
                self.devTwo.frame = self.devTwo.frame.offsetBy(dx: 0, dy: -119)
                
        },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 5.8,
            animations: {
                self.devThree.alpha = 1.0
                self.devThree.frame = self.devThree.frame.offsetBy(dx: 0, dy: -89)
                },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 6.4,
            animations: {
                self.devFour.alpha = 1.0
                self.devFour.frame = self.devFour.frame.offsetBy(dx: 0, dy: -59)
        }, completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 1.8,
            animations: {
                self.devFive.alpha = 1.0
                self.devFive.frame = self.devFive.frame.offsetBy(dx: 0, dy: -334)
        },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 3.0,
            animations: {
                self.devSix.alpha = 1.0
                self.devSix.frame = self.devSix.frame.offsetBy(dx: 0, dy: -259)
        }, completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 0.6,
            animations: {
                self.devSeven.alpha = 1.0
                self.devSeven.frame = self.devSeven.frame.offsetBy(dx: 0, dy: -409)
        }, completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 3.4,
            animations: {
                self.devEight.alpha = 1.0
                self.devEight.frame = self.devEight.frame.offsetBy(dx: 0, dy: -229)
        }, completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 7.0,
            animations: {
                self.devNine.alpha = 1.0
                self.devNine.frame = self.devNine.frame.offsetBy(dx: 0, dy: -29)
        }, completion: nil)
    }

    
}
