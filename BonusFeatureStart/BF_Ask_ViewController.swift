//
//  BF_Ask_ViewController.swift
//  BonusFeatureStart
//
//  Created by Joshua on 3/29/18.
//  Copyright © 2018 NASA. All rights reserved.
//

import UIKit

class BF_Ask_ViewController: UIViewController {

    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var noThanksButton: UIButton!
    @IBOutlet weak var letsPlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
        setStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func setStyle() {
        textView.layer.cornerRadius = 8
        noThanksButton.layer.borderColor = UIColor.gray.cgColor
        noThanksButton.layer.borderWidth = 1
        noThanksButton.layer.cornerRadius = 13
        noThanksButton.setTitleColor(UIColor.gray, for: .normal)
        letsPlayButton.backgroundColor = UIColor.orange
        letsPlayButton.setTitleColor(UIColor.white, for: .normal)
        letsPlayButton.layer.cornerRadius = 13
    }
    
    @IBAction func NoThanksPressed(_ sender: Any) {
    }
    
    @IBAction func LetsPlayPressed(_ sender: Any) {
        performSegue(withIdentifier: "toProfileSegue", sender: self)
    }
    
    
}

