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
class AvatarView: UIImageView {
    var imageShowing = 0
    var normalImg = ""
    var grayImg = ""
    
    // Constructor, pass in names of the normal image and the greyed out image
    init(normalImg: String, grayImg: String) {
        super.init(image: UIImage(named: normalImg))
        
        self.normalImg = normalImg
        self.grayImg = grayImg
    }
    
    // Required for creating a subclass of UIImageView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Toggle image shown
    func toggleImg() {
        if imageShowing == 0 {
            // change img
        } else {
            // change img
        }
    }
}

class TriviaProfileViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var readyBtn: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    
    var avatars = [AvatarView]()
    
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
        let a1 = AvatarView(normalImg: "Trivia-Moon", grayImg: "")
        a1.frame = CGRect(x: 32, y: 187, width: 62, height: 62)
        let a2 = AvatarView(normalImg: "Trivia-Earth", grayImg: "")
        a2.frame = CGRect(x: 109, y: 187, width: 62, height: 62)
        let a3 = AvatarView(normalImg: "Trivia-Star", grayImg: "")
        a3.frame = CGRect(x: 187, y: 187, width: 62, height: 62)
        
        // 2nd row
        let a4 = AvatarView(normalImg: "Trivia-Asteroid", grayImg: "")
        a4.frame = CGRect(x: 32, y: 270, width: 62, height: 62)
        let a5 = AvatarView(normalImg: "Trivia-Sun", grayImg: "")
        a5.frame = CGRect(x: 109, y: 270, width: 62, height: 62)
        let a6 = AvatarView(normalImg: "Trivia-Saturn", grayImg: "")
        a6.frame = CGRect(x: 187, y: 270, width: 62, height: 62)
        
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
            // Add tap handler
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            avatar.isUserInteractionEnabled = true
            avatar.addGestureRecognizer(tap)
        }
    }
    
    // Tap handler
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! AvatarView
        print("?tapped")
        let context = CIContext(options: nil)
         let currentFilter = CIFilter(name: "CIPhotoEffectTonal")
         currentFilter!.setValue(CIImage(image: tappedImage.image!), forKey: kCIInputImageKey)
         let output = currentFilter!.outputImage
         let cgimg = context.createCGImage(output!,from: output!.extent)
         let processedImage = UIImage(cgImage: cgimg!)
         tappedImage.image = processedImage
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
