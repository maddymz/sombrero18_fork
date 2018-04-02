//
//  TriviaInitViewController.swift
//  PsycheTimeline
//
//  Created by Joshua on 4/1/18.
//  Copyright © 2018 sombrero. All rights reserved.
//

import UIKit
import Foundation

class TriviaInitViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var noThanksBtn: UIButton!
    @IBOutlet weak var letsPlayBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.layer.zPosition = -1 // Hides the tab bar
        setGradientBackground()
        setStyle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.tabBarController?.tabBar.layer.zPosition = 0 // Shows the tab bar again
        tabBarController?.selectedIndex = 0 // This points to the root tab bar controller
    }
    
    @IBAction func noThanksBtnPressed(_ sender: Any) {
        self.tabBarController?.tabBar.layer.zPosition = 0 // Shows the tab bar again
        tabBarController?.selectedIndex = 0 // This points to the root tab bar controller
    }
    
    // Goes to the "Create a profile" screen
    @IBAction func letsPlayBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toProfileCreate", sender: self)
    }
    
    // Sets background color of orange to red gradient
    func setGradientBackground() {
        let colorTop =  UIColor(red: 216.0/255.0, green: 112.0/255.0, blue: 43.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 241.0/255.0, green: 101.0/255.0, blue: 85.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom ]
        gradientLayer.locations = [ 0.0, 1.0 ]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Set rounded corners and button colors
    func setStyle() {
        mainView.layer.cornerRadius = 8
        noThanksBtn.layer.borderColor = UIColor.gray.cgColor
        noThanksBtn.layer.borderWidth = 1
        noThanksBtn.layer.cornerRadius = 13
        noThanksBtn.setTitleColor(UIColor.gray, for: .normal)
        letsPlayBtn.backgroundColor = UIColor.orange
        letsPlayBtn.setTitleColor(UIColor.white, for: .normal)
        letsPlayBtn.layer.cornerRadius = 13
    }
}
