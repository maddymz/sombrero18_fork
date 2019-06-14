//
//  TriviaProfileViewController.swift
//  Psyche
//
//  Created by Joshua on 4/1/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import Foundation
import CoreData

// Custom UIImageView class for the avatars
class AvatarButton: UIButton {
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
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var backgroundGradient: UIImageView!
    @IBOutlet weak var usernameLengthLabel: UILabel!
    
    
    @IBOutlet weak var nasaLogo: UIButton!
    var avatars = [AvatarButton]()
    var profileSelected = -1 // Id of the AvatarButton selected, -1 represents no avatar has been selected
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() // Hide keyboard if user taps somewhere else
        
        //setGradientBackground()
        setStyle()
        createAvatarButtons()
        screenLayout()
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TriviaInfo")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
        let result = try context.execute(request)
        } catch {
         
        }*/
    }
    
    
    // handle screen layout - by Madhukar Raj , 06/03/2019
    func screenLayout(){
        
        let guide = view.safeAreaLayoutGuide
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.nasaLogo.translatesAutoresizingMaskIntoConstraints = true
        self.backButton.translatesAutoresizingMaskIntoConstraints = true
        
        if UIDevice.current.screenType == .iPhone_XR{
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.backButton.translatesAutoresizingMaskIntoConstraints = false
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 69).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -70).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -240).isActive = true
            backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
            backButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
            
        } else if UIDevice.current.screenType == .iPhone_XSMax {
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.backButton.translatesAutoresizingMaskIntoConstraints = false
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 69).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -70).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -240).isActive = true
            backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
            backButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        } else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
           
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 69).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -70).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 100).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -200).isActive = true
        } else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 28).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -27).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 70).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -70).isActive = true
        } else if UIDevice.current.screenType == .iPhones_X_XS {
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.backButton.translatesAutoresizingMaskIntoConstraints = false
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 48).isActive = true
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -47).isActive = true
            mainView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -160).isActive = true
            backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
            backButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toExit", sender: self)
    }
    
    @IBAction func readyBtnPressed(_ sender: Any) {
        if let uname = usernameField.text, uname.count >= 20 {
            usernameLengthLabel.isHidden = false // Show user that username must be less than 20 characters
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TriviaInfo")
            request.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(request)
                
                var username = ""
                if let uname = usernameField.text, uname.count > 0 { // If username is not blank
                    username = uname
                } else { // If username is blank, set default
                    username = "Player 16"
                }
                var avatar = 0
                if profileSelected != -1 {
                    avatar = profileSelected
                } else {
                    avatar = Int(arc4random() % 6) + 1 // Random int between 1 and 6
                }
                
                if results.count > 0 { // If there is already a profile created
                    // Updating core data
                    let result = results.first as! NSManagedObject
                    if(usernameField.text?.count != 0){
                        result.setValue(username, forKey: "username")
                    }
                    result.setValue(avatar, forKey: "avatar")
                } else { // No profile created yet, create one
                    // Inserting into core data
                    let triviaProfile = NSEntityDescription.insertNewObject(forEntityName: "TriviaInfo", into: context)
                    
                    triviaProfile.setValue(username, forKey: "username")
                    triviaProfile.setValue(avatar, forKey: "avatar")
                    
                    triviaProfile.setValue(0, forKey: "high_score")
                    triviaProfile.setValue(1, forKey: "levels_unlocked")
                }
            } catch { }
            
            do {
                try context.save() // Save profile info to core data
            } catch { }
            
            performSegue(withIdentifier: "toTriviaOpponent", sender: self)
        }
    }
    
    // Create six image views for avatars
    func createAvatarButtons() {
        // 32 space on each side and 62 is the width of the avatar
        let space = (Int(mainView.frame.width) - 64 - 62 * 3) / 2 + 62
        
        // 1st row
        let a1 = AvatarButton(normalImg: "Trivia-Moon", grayImg: "Trivia-MoonBW", frame: CGRect(x: 32, y: 187, width: 62, height: 62), id: 3)
        let a2 = AvatarButton(normalImg: "Trivia-Earth", grayImg: "Trivia-EarthBW", frame: CGRect(x: 32 + space, y: 187, width: 62, height: 62), id: 2)
        let a3 = AvatarButton(normalImg: "Trivia-Star", grayImg: "Trivia-StarBW", frame: CGRect(x: 32 + space + space, y: 187, width: 62, height: 62), id: 5)
        
        // 2nd row
        let a4 = AvatarButton(normalImg: "Trivia-Asteroid", grayImg: "Trivia-AsteroidBW", frame: CGRect(x: 32, y: 270, width: 62, height: 62), id: 1)
        let a5 = AvatarButton(normalImg: "Trivia-Sun", grayImg: "Trivia-SunBW", frame: CGRect(x: 32 + space, y: 270, width: 62, height: 62), id: 6)
        let a6 = AvatarButton(normalImg: "Trivia-Saturn", grayImg: "Trivia-SaturnBW", frame: CGRect(x: 32 + space + space, y: 270, width: 62, height: 62), id: 4)
        
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
        
        // Add tap handler for each AvatarButton
        avatars.forEach { (avatar) in
            avatar.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
        }
    }
    
    // Function executed when user taps on AvatarButton
    @objc func pressButton(_ sender: AvatarButton) {
        // If user tapped on avatar when another one was selected
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
        
        skipBtn.layer.borderColor = UIColor.gray.cgColor
        skipBtn.layer.borderWidth = 1
        skipBtn.layer.cornerRadius = 13
        skipBtn.setTitleColor(UIColor.gray, for: .normal)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func openNASA(_ sender: Any) {
        menuHelper.openNASA(vc: self)
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
