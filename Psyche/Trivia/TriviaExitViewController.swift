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
        screenLayout()
    }
    
    // handle screen layout - by Madhukar Raj , 06/03/2019
    func screenLayout(){
        
        let guide = view.safeAreaLayoutGuide
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        if UIDevice.current.screenType == .iPhone_XR{
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 69).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -70).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 133).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -470).isActive = true
        } else if UIDevice.current.screenType == .iPhone_XSMax {
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 69).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -70).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 133).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -470).isActive = true
        } else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 69).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -70).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 133).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -370).isActive = true
        } else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 28).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -27).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 105).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -220).isActive = true
        } else if UIDevice.current.screenType == .iPhones_X_XS {
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 48).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -47).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 133).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -400).isActive = true
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomePage" {
            if let vc = segue.destination as? LoadingViewController {
                vc.showAnimation = false // This ensures that the LoadingViewController will not show the animation
            }
        }

    }
    
//    @IBAction func unwinedToMainScreen (segue: UIStoryboardSegue){
//        print("to the homescreen...!!!")
//    }
    
    @IBAction func yesBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toHomePage", sender: self) // Performs segue to the tab bar controller which goes to the home tab
    }

    @IBAction func noBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toProfile", sender: self)
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
