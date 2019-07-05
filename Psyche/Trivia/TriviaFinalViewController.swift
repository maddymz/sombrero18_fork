//
//  TriviaFinalViewController.swift
//  Psyche
//
//  Created by Julia Liu on 4/8/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import CoreData
import TwitterKit

class TriviaFinalViewController: UIViewController {


    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var vsLabel: UILabel!
    
    @IBOutlet weak var completeMessage: UILabel!
    
    @IBOutlet weak var shareMessage: UILabel!
    
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var nasaLogo: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    //category buttons
    
    @IBOutlet weak var opponentQuote: UILabel!
    var category: String?
    var opponent: OpponentData?
    var profile_image = 1
    var finalScore = 0;
    
    @IBOutlet weak var letsPlayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if finalScore < (opponent?.highScore)! {
            self.share.isHidden = true
            self.shareButton.isHidden = true
            self.letsPlayButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.letsPlayButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
            self.letsPlayButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
            self.letsPlayButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            self.letsPlayButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TriviaInfo")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            // This is a for loop but there should only be one object in core data
            for result in results as! [NSManagedObject] {
                // Get username
                if let username = result.value(forKey: "username") as? String {
                    print(username)
                    profileName.text = username
                } else {
                    print("no username")
                }
                
                // Get avatar
                if let avatar = result.value(forKey: "avatar") as? Int {
                    print(avatar)
                    profile_image = avatar
                } else {
                    print("no avatar")
                }
                
                // Get high score
                if let highScore = result.value(forKey: "high_score") as? Int {
                    print(highScore)
                    if(highScore < finalScore)
                    {
                        result.setValue(finalScore, forKey: "high_score")
                    }
                } else {
                    print("no high score")
                }
                
                // Get high score
                if let levels_unlocked = result.value(forKey: "levels_unlocked") as? Int {
                    print(levels_unlocked)
                    if(finalScore > (opponent?.highScore)! && levels_unlocked == opponent?.level){
                        result.setValue(levels_unlocked + 1, forKey: "levels_unlocked")
                    }
                } else {
                    print("no levels_unlocked")
                }
            }
        } catch {
        }
        do {
            try context.save() // Save profile info to core data
        } catch { }
        
        opponentAvatar.image = UIImage(named: (opponent?.unlockedImage)!)
        if(profile_image == 1){
            profile.image = #imageLiteral(resourceName: "Asteroid_Large")
        }
        else if(profile_image == 2){
            profile.image = #imageLiteral(resourceName: "Earth_Large")
        }
        else if(profile_image == 3){
            profile.image = #imageLiteral(resourceName: "Moon_Large")
        }
        else if(profile_image == 4){
            profile.image = #imageLiteral(resourceName: "Saturn_Large")
        }
        else if(profile_image == 5){
            profile.image = #imageLiteral(resourceName: "Star_Large")
        }
        else if(profile_image == 6){
            profile.image = #imageLiteral(resourceName: "Sun_Large")
        }
        opponentName.text = opponent?.fname
        opponentQuote.text = "\"" + (opponent?.quote)! + "\"\n- " + (opponent?.name)!
        finalScoreLabel.text = String(finalScore)
        mainView.layer.cornerRadius = 8
        opponentScoreLabel.text = String((opponent?.highScore)!)
        
        if(finalScore > (opponent?.highScore)!){
            completeMessage.text = "Congrats, You Won!"
        }
        else{
            completeMessage.text = "It's ok, You can try again!"
        }
        
        screenLayout()
    }
    @IBAction func systemShare(_ sender: Any) {
        let message = "I beat \(self.opponentName.text!) with a score of \(self.finalScoreLabel.text!)! #Psyche"
        let image:UIImage = takeScreenshot()!
        let activityController = UIActivityViewController(activityItems: [message, image],
                                                          applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func shareDialog(_ sender: Any) {
        let option1 = false //Set to true when not on simulator
        if(option1) {
            if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
                // App must have at least one logged-in user to compose a Tweet
                let composer = TWTRComposerViewController(initialText: "I beat \(self.opponentName.text!) with a score of \(self.finalScoreLabel.text!)! #Psyche", image: self.takeScreenshot(), videoData : nil)
                present(composer, animated: true, completion: nil)
            } else {
                // Log in, and then check again
                TWTRTwitter.sharedInstance().logIn { session, error in
                    if session != nil { // Log in succeeded
                        let composer = TWTRComposerViewController(initialText: "I beat \(self.opponentName.text!) with a score of \(self.finalScoreLabel.text!)! #Psyche", image: self.takeScreenshot(), videoData : nil)
                        //composer.delegate = self
                        self.present(composer, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                        self.present(alert, animated: false, completion: nil)
                    }
                }
            }
        }
        else{
            let message = "I beat \(self.opponentName.text!) with a score of \(self.finalScoreLabel.text!)! #Psyche"
            let image:UIImage = takeScreenshot()!
            let activityController = UIActivityViewController(activityItems: [message, image],
                                                              applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let _ = screenshotImage, shouldSave {
            //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        return screenshotImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTabController"{
            if let vc = segue.destination as? LoadingViewController {
                vc.showAnimation = false // This ensures that the LoadingViewController will not show the animation
            }
        }
    }
    
    // handle screen layout - by Madhukar Raj , 06/03/2019
    func screenLayout(){
        let guide = view.safeAreaLayoutGuide
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            
            opponentAvatar.translatesAutoresizingMaskIntoConstraints = false
            opponentName.translatesAutoresizingMaskIntoConstraints = false
            profile.translatesAutoresizingMaskIntoConstraints = false
            profileName.translatesAutoresizingMaskIntoConstraints = false
            opponentScoreLabel.translatesAutoresizingMaskIntoConstraints = false
            finalScoreLabel.translatesAutoresizingMaskIntoConstraints = false
            completeMessage.translatesAutoresizingMaskIntoConstraints = false
            mainView.translatesAutoresizingMaskIntoConstraints = false
            shareMessage.translatesAutoresizingMaskIntoConstraints = false
            share.translatesAutoresizingMaskIntoConstraints = false
            self.opponentQuote.translatesAutoresizingMaskIntoConstraints = false
            opponentAvatar.widthAnchor.constraint(equalToConstant: 130).isActive = true
            opponentAvatar.heightAnchor.constraint(equalToConstant: 130).isActive = true
            opponentAvatar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            opponentAvatar.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
            opponentName.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150).isActive = true
            opponentName.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -60).isActive = true
            opponentScoreLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 170).isActive = true
            opponentScoreLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -50).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 130).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 130).isActive = true
            profile.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
            profile.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
            profileName.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150).isActive = true
            profileName.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40).isActive = true
            finalScoreLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 170).isActive = true
            finalScoreLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 55).isActive = true
            mainView.widthAnchor.constraint(equalToConstant: 225).isActive = true
            mainView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            completeMessage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
            completeMessage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
            completeMessage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 25).isActive = true
            completeMessage.font = UIFont(name: completeMessage.font.fontName, size: 20)
            shareMessage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
            shareMessage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
            shareMessage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 100).isActive = true
            shareMessage.font = UIFont(name: completeMessage.font.fontName, size: 14)
            mainView.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 3).isActive = true
            mainView.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: 50).isActive = true
            share.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5).isActive = true
            share.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5).isActive = true
            self.opponentQuote.font = UIFont(name: self.opponentQuote.font.fontName, size: 10)
            self.opponentQuote.topAnchor.constraint(equalTo: guide.topAnchor, constant: 444).isActive = true
            self.opponentQuote.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 4).isActive = true
            self.opponentQuote.widthAnchor.constraint(equalToConstant: 232).isActive = true
        } else if UIDevice.current.screenType == .iPhone_XSMax {
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            closeButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: -15).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
            
        } else if UIDevice.current.screenType == .iPhone_XR {
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            closeButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: -15).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        } else if UIDevice.current.screenType == .iPhones_X_XS {
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            closeButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: -15).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        }
    }
}
