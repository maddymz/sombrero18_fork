//
//  TriviaProfileViewController.swift
//  Psyche
//
//  Created by Joshua on 4/1/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import Foundation

// Custom UIImageView class for the avatars
class AvatarView: UIButton {
    var imageShowing = 0 // 0 represents the normal image showing, 1 represents the gray (BW) image showing
    var normalImg = ""
    var grayImg = ""
    var id = 0
    
    // Constructor, pass in names of the normal image and the greyed out image
    init(normalImg: String, grayImg: String, frame: CGRect, id: Int) {
        super.init(frame: frame)
        
        self.setTitle("", for: .normal)
        self.setImage(UIImage(named: normalImg), for: .normal)
        self.setImage(UIImage(named: normalImg), for: .highlighted)
        self.normalImg = normalImg
        self.grayImg = grayImg
        self.id = id
    }
    
    // Required for creating a subclass of UIImageView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Toggle image shown
    func toggleImg() {
        if imageShowing == 0 {
            self.setImage(UIImage(named: grayImg), for: .normal)
            self.setImage(UIImage(named: grayImg), for: .highlighted)
            imageShowing = 1
        } else {
            self.setImage(UIImage(named: normalImg), for: .normal)
            self.setImage(UIImage(named: normalImg), for: .highlighted)
            imageShowing = 0
        }
    }
}

class TriviaProfileViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var readyBtn: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    
    var avatars = [AvatarView]()
    var profileSelected = -1 // Id of the AvatarView selected, -1 represents no avatar has been selected
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
        setStyle()
        createAvatarViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toExit", sender: self)
    }
    
    @IBAction func readyBtnPressed(_ sender: Any) {
        // Not implemented yet
    }
    
    // Create six image views for avatars
    func createAvatarViews() {
        // 1st row
        let a1 = AvatarView(normalImg: "Trivia-Moon", grayImg: "Trivia-EarthBW", frame: CGRect(x: 32, y: 187, width: 62, height: 62), id: 0)
        let a2 = AvatarView(normalImg: "Trivia-Earth", grayImg: "Trivia-EarthBW", frame: CGRect(x: 109, y: 187, width: 62, height: 62), id: 1)
        let a3 = AvatarView(normalImg: "Trivia-Star", grayImg: "Trivia-StarBW", frame: CGRect(x: 187, y: 187, width: 62, height: 62), id: 2)
        
        // 2nd row
        let a4 = AvatarView(normalImg: "Trivia-Asteroid", grayImg: "Trivia-AsteroidBW", frame: CGRect(x: 32, y: 270, width: 62, height: 62), id: 3)
        let a5 = AvatarView(normalImg: "Trivia-Sun", grayImg: "Trivia-SunBW", frame: CGRect(x: 109, y: 270, width: 62, height: 62), id: 4)
        let a6 = AvatarView(normalImg: "Trivia-Saturn", grayImg: "Trivia-SaturnBW", frame: CGRect(x: 187, y: 270, width: 62, height: 62), id: 5)
        
        // Add to array
        avatars.append(a1)
        avatars.append(a2)
        avatars.append(a3)
        avatars.append(a4)
        avatars.append(a5)
        avatars.append(a6)
        
        // Add to mainView
        mainView.addSubview(a1)
        mainView.addSubview(a2)
        mainView.addSubview(a3)
        mainView.addSubview(a4)
        mainView.addSubview(a5)
        mainView.addSubview(a6)
        
        // Add tap handler for each AvatarView
        avatars.forEach { (avatar) in
            avatar.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
        }
    }
    
    //The target function
    @objc func pressButton(_ sender: AvatarView) {
        print("sender: \(sender.id)")
        if profileSelected != -1 && profileSelected != sender.id {
            avatars.forEach { (avatar) in
                if avatar.id == sender.id || avatar.id == profileSelected {
                    avatar.toggleImg()
                }
            }
        } else {
            avatars.forEach { (avatar) in
                if avatar.id != sender.id {
                    avatar.toggleImg()
                }
            }
        }
        
        if profileSelected == sender.id {
            profileSelected = -1 // User clicked on the selected profile, so reset to show there is no profile selected
        } else {
            profileSelected = sender.id
        }
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
        
        usernameField.borderStyle = .none
        usernameField.layer.backgroundColor = UIColor.white.cgColor
        usernameField.layer.masksToBounds = false
        usernameField.layer.shadowColor = UIColor.gray.cgColor
        usernameField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        usernameField.layer.shadowOpacity = 1.0
        usernameField.layer.shadowRadius = 0.0
        
        readyBtn.backgroundColor = UIColor.orange
        readyBtn.setTitleColor(UIColor.white, for: .normal)
        readyBtn.layer.cornerRadius = 13
    }
}
