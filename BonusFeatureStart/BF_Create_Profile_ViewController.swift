//
//  BF_Create_Profile_ViewController.swift
//  BonusFeatureStart
//
//  Created by Joshua on 3/29/18.
//  Copyright © 2018 NASA. All rights reserved.
//

import UIKit

class AvatarView1 : UIImageView {
    var grayed = 0
}

class AvatarView {
    @IBOutlet weak var avatar: UIImageView!
    var grayed = 0
}

class BF_Create_Profile_ViewController: UIViewController {
    
    @IBOutlet weak var textView: UIView! // White view containing elements
    @IBOutlet weak var usernameField: UITextField! // Text field for user name
    @IBOutlet weak var readyButton: UIButton! // Button that says "I'm ready"
    
    @IBOutlet weak var avatar1: UIImageView!
    @IBOutlet weak var avatar2: UIImageView!
    @IBOutlet weak var avatar3: UIImageView!
    @IBOutlet weak var avatar4: UIImageView!
    @IBOutlet weak var avatar5: UIImageView!
    @IBOutlet weak var avatar6: UIImageView!
    
    //@IBOutlet var avatars:[UIImageView]!
    
    var avatars = [AvatarView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAvatars()
        addTapHandlers()
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
        
        usernameField.borderStyle = .none
        usernameField.layer.backgroundColor = UIColor.white.cgColor
        usernameField.layer.masksToBounds = false
        usernameField.layer.shadowColor = UIColor.gray.cgColor
        usernameField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        usernameField.layer.shadowOpacity = 1.0
        usernameField.layer.shadowRadius = 0.0
        
        readyButton.backgroundColor = UIColor.orange
        readyButton.setTitleColor(UIColor.white, for: .normal)
        readyButton.layer.cornerRadius = 13
        
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectTonal")
        currentFilter!.setValue(CIImage(image: avatar1.image!), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        avatar1.image = processedImage
    }
    
    func addAvatars() {
        let a1 = AvatarView()
        a1.avatar = avatar1
        let a2 = AvatarView()
        a2.avatar = avatar2
        let a3 = AvatarView()
        a3.avatar = avatar3
        let a4 = AvatarView()
        a4.avatar = avatar4
        let a5 = AvatarView()
        a5.avatar = avatar5
        let a6 = AvatarView()
        a6.avatar = avatar6
        
        avatars.append(a1)
        avatars.append(a2)
        avatars.append(a3)
        avatars.append(a4)
        avatars.append(a5)
        avatars.append(a6)
    }
    
    func addTapHandlers() {
        /*let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)*/
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
    }
}


