//
//  TriviaExitViewController.swift
//  Psyche
//
//  Created by Joshua on 4/1/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import Foundation

class TriviaExitViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setGradientBackground()
        setStyle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTabController"{
            if let vc = segue.destination as? LoadingViewController {
                vc.showAnimation = false // This ensures that the LoadingViewController will not show the animation
            }
        }
    }
    
    @IBAction func yesBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toTabController", sender: self) // Performs segue to the tab bar controller which goes to the home tab
    }
    
//    @IBAction func noBtnPressed(_ sender: Any) {
//        performSegue(withIdentifier: "toProfile", sender: self)
//    }
    
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
    
    // Makes corners rounded and sets button styles
    func setStyle() {
        mainView.layer.cornerRadius = 8
        
        noBtn.layer.borderColor = UIColor.gray.cgColor
        noBtn.layer.borderWidth = 1
        noBtn.layer.cornerRadius = 13
        noBtn.setTitleColor(UIColor.gray, for: .normal)
        
        yesBtn.backgroundColor = UIColor.orange
        yesBtn.setTitleColor(UIColor.white, for: .normal)
        yesBtn.layer.cornerRadius = 13
    }
}
