//
//  AboutGalleryViewController.swift
//  Psyche
//
//  Created by Madhukar Raj on 6/27/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import UIKit

class AboutGalleryViewController: UIViewController {

    @IBOutlet weak var devThree: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var bckGround: UIImageView!
    @IBOutlet weak var graphicDesign: UILabel!
    @IBOutlet weak var devTwo: UILabel!
    @IBOutlet weak var devLabel: UILabel!
    @IBOutlet weak var devFour: UILabel!
    @IBOutlet weak var prManager: UILabel!
    @IBOutlet weak var devFive: UILabel!
    @IBOutlet weak var srDev: UILabel!
    @IBOutlet weak var devSix: UILabel!
    @IBOutlet weak var devEight: UILabel!
    @IBOutlet weak var devSeven: UILabel!
    @IBOutlet weak var devOne: UILabel!
    @IBOutlet weak var devNine: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        animateContent()
    }
    
    func layout() {
        
        self.version.translatesAutoresizingMaskIntoConstraints = false
        self.bckGround.translatesAutoresizingMaskIntoConstraints = false
        self.bckGround.leadingAnchor.constraint(equalTo: view.leadingAnchor ).isActive = true
        self.bckGround.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bckGround.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bckGround.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.devOne.alpha = 0.0
        self.devTwo.alpha = 0.0
        self.devThree.alpha = 0.0
        self.devFour.alpha = 0.0
        self.devFive.alpha = 0.0
        self.devSix.alpha = 0.0
        self.devSeven.alpha = 0.0
        self.devEight.alpha = 0.0
        self.devNine.alpha = 0.0
        self.srDev.alpha = 0.0
        self.prManager.alpha = 0.0
        self.graphicDesign.alpha = 0.0
        self.devLabel.alpha = 0.0
        
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            self.srDev.frame = CGRect(x: 120.26, y: 550, width: 132, height: 21)
            self.prManager.frame = CGRect(x: 124.08, y: 550, width: 126, height: 21)
            self.graphicDesign.frame = CGRect(x: 116.43, y: 550, width: 142, height: 21)
            self.devLabel.frame = CGRect(x: 143.18, y: 550, width: 87, height: 21)
            
            self.teamLabel.frame = CGRect(x: 104, y: 63, width: 169, height: 24)
            self.version.frame = CGRect(x: 117.71, y: 609, width: 137, height: 38)
            self.version.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.version.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            
            
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
            self.srDev.frame = CGRect(x: 140.36, y: 550, width: 132, height: 21)
            self.prManager.frame = CGRect(x: 143.7, y: 550, width: 126, height: 21)
            self.graphicDesign.frame = CGRect(x: 135.34, y: 550, width: 142, height: 21)
            self.devLabel.frame = CGRect(x: 162.08, y: 550, width: 87, height: 21)
            
            self.teamLabel.frame = CGRect(x: 120, y: 63, width: 169, height: 24)
            self.version.frame = CGRect(x: 138.43, y: 609, width: 137, height: 38)
            self.version.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.version.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            
            
            
            self.devOne.frame = CGRect(x: 143.7, y: 550, width: 125, height: 21)
            self.devTwo.frame = CGRect(x: 162.08, y: 550, width: 89, height: 21)
            self.devThree.frame = CGRect(x: 170.44, y: 550, width: 72, height: 21)
            self.devFour.frame = CGRect(x: 175.45, y: 550, width: 62, height: 21)
            self.devFive.frame = CGRect(x: 158.74, y: 550, width: 94, height: 21)
            self.devSix.frame = CGRect(x: 137.01, y: 550, width: 139, height: 21)
            self.devSeven.frame = CGRect(x: 153.73, y: 550, width: 105, height: 21)
            self.devEight.frame = CGRect(x: 138.68, y: 550, width: 135, height: 21)
            self.devNine.frame = CGRect(x: 158.74, y: 550, width: 94, height: 21)
        }else if UIDevice.current.screenType == .iPhone_XSMax {
            self.srDev.frame = CGRect(x: 140.36, y: 550, width: 132, height: 21)
            self.prManager.frame = CGRect(x: 143.7, y: 550, width: 126, height: 21)
            self.graphicDesign.frame = CGRect(x: 135.34, y: 550, width: 142, height: 21)
            self.devLabel.frame = CGRect(x: 162.08, y: 550, width: 87, height: 21)
            
            self.teamLabel.frame = CGRect(x: 120, y: 63, width: 169, height: 24)
            self.version.frame = CGRect(x: 138.43, y: 609, width: 137, height: 38)
            self.version.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.version.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

            
            
            self.devOne.frame = CGRect(x: 143.7, y: 550, width: 125, height: 21)
            self.devTwo.frame = CGRect(x: 162.08, y: 550, width: 89, height: 21)
            self.devThree.frame = CGRect(x: 170.44, y: 550, width: 72, height: 21)
            self.devFour.frame = CGRect(x: 175.45, y: 550, width: 62, height: 21)
            self.devFive.frame = CGRect(x: 158.74, y: 550, width: 94, height: 21)
            self.devSix.frame = CGRect(x: 137.01, y: 550, width: 139, height: 21)
            self.devSeven.frame = CGRect(x: 153.73, y: 550, width: 105, height: 21)
            self.devEight.frame = CGRect(x: 138.68, y: 550, width: 135, height: 21)
            self.devNine.frame = CGRect(x: 158.74, y: 550, width: 94, height: 21)
        }else if UIDevice.current.screenType == .iPhone_XR {
            self.srDev.frame = CGRect(x: 140.36, y: 550, width: 132, height: 21)
            self.prManager.frame = CGRect(x: 143.7, y: 550, width: 126, height: 21)
            self.graphicDesign.frame = CGRect(x: 135.34, y: 550, width: 142, height: 21)
            self.devLabel.frame = CGRect(x: 162.08, y: 550, width: 87, height: 21)
            
            self.teamLabel.frame = CGRect(x: 120, y: 63, width: 169, height: 24)
            self.version.frame = CGRect(x: 138.43, y: 609, width: 137, height: 38)
            self.version.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.version.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            
            
            
            self.devOne.frame = CGRect(x: 143.7, y: 550, width: 125, height: 21)
            self.devTwo.frame = CGRect(x: 162.08, y: 550, width: 89, height: 21)
            self.devThree.frame = CGRect(x: 170.44, y: 550, width: 72, height: 21)
            self.devFour.frame = CGRect(x: 175.45, y: 550, width: 62, height: 21)
            self.devFive.frame = CGRect(x: 158.74, y: 550, width: 94, height: 21)
            self.devSix.frame = CGRect(x: 137.01, y: 550, width: 139, height: 21)
            self.devSeven.frame = CGRect(x: 153.73, y: 550, width: 105, height: 21)
            self.devEight.frame = CGRect(x: 138.68, y: 550, width: 135, height: 21)
            self.devNine.frame = CGRect(x: 158.74, y: 550, width: 94, height: 21)
        }else if UIDevice.current.screenType == .iPhones_X_XS {
            self.srDev.frame = CGRect(x: 120.26, y: 550, width: 132, height: 21)
            self.prManager.frame = CGRect(x: 124.08, y: 550, width: 126, height: 21)
            self.graphicDesign.frame = CGRect(x: 116.43, y: 550, width: 142, height: 21)
            self.devLabel.frame = CGRect(x: 143.18, y: 550, width: 87, height: 21)
            
            self.teamLabel.frame = CGRect(x: 104, y: 63, width: 169, height: 24)
            self.version.frame = CGRect(x: 117.71, y: 609, width: 137, height: 38)
            self.version.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.version.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            
            
            self.devOne.frame = CGRect(x: 124, y: 550, width: 125, height: 21)
            self.devTwo.frame = CGRect(x: 142, y: 550, width: 89, height: 21)
            self.devThree.frame = CGRect(x: 150.83, y: 550, width: 72, height: 21)
            self.devFour.frame = CGRect(x: 156, y: 550, width: 62, height: 21)
            self.devFive.frame = CGRect(x: 140, y: 550, width: 94, height: 21)
            self.devSix.frame = CGRect(x: 117, y: 550, width: 139, height: 21)
            self.devSeven.frame = CGRect(x: 134.27, y: 550, width: 105, height: 21)
            self.devEight.frame = CGRect(x: 119.5, y: 550, width: 135, height: 21)
            self.devNine.frame = CGRect(x: 140, y: 550, width: 94, height: 21)
        }else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            self.srDev.frame = CGRect(x: 93.55, y: 550, width: 132, height: 21)
            self.prManager.frame = CGRect(x: 96.9, y: 550, width: 126, height: 21)
            self.graphicDesign.frame = CGRect(x: 85.54, y: 550, width: 142, height: 21)
            self.devLabel.frame = CGRect(x: 115.28, y: 550, width: 87, height: 21)
            
            self.teamLabel.frame = CGRect(x: 75, y: 63, width: 169, height: 24)
            self.version.frame = CGRect(x: 91.47, y: 610, width: 137, height: 38)
            self.version.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.version.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
            
            
            self.devOne.frame = CGRect(x: 96.9, y: 550, width: 125, height: 21)
            self.devTwo.frame = CGRect(x: 115.28, y: 550, width: 89, height: 21)
            self.devThree.frame = CGRect(x: 123.64, y: 550, width: 72, height: 21)
            self.devFour.frame = CGRect(x: 128.65, y: 550, width: 62, height: 21)
            self.devFive.frame = CGRect(x: 111.94, y: 550, width: 94, height: 21)
            self.devSix.frame = CGRect(x: 90.21, y: 550, width: 139, height: 21)
            self.devSeven.frame = CGRect(x: 106.92, y: 550, width: 105, height: 21)
            self.devEight.frame = CGRect(x: 91.88, y: 550, width: 135, height: 21)
            self.devNine.frame = CGRect(x: 111.94, y: 550, width: 94, height: 21)
        }
        
        
        
    }
    func animateContent () {
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 0,
            animations: {
                self.srDev.alpha = 1.0
                self.srDev.frame = self.srDev.frame.offsetBy(dx: 0, dy: -444)
        },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 1.2,
            animations: {
                self.prManager.alpha = 1.0
                self.prManager.frame = self.prManager.frame.offsetBy(dx: 0, dy: -369)
        },
            completion: nil)
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 2.4,
            animations: {
                self.graphicDesign.alpha = 1.0
                self.graphicDesign.frame = self.graphicDesign.frame.offsetBy(dx: 0, dy: -294)
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
