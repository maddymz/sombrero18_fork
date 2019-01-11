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
    
    
    
    //category buttons
    
    @IBOutlet weak var opponentQuote: UILabel!
    var category: String?
    var opponent: OpponentData?
    var profile_image = 1
    var finalScore = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if let image = screenshotImage, shouldSave {
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
}
