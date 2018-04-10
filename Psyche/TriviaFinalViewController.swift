//
//  TriviaFinalViewController.swift
//  Psyche
//
//  Created by Julia Liu on 4/8/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit

class TriviaFinalViewController: UIViewController {

    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    //category buttons
    
    @IBOutlet weak var opponentQuote: UILabel!
    var category: String?
    var opponent: Opponent?
    var profile_image = 1
    var finalScore = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        opponentAvatar.image = opponent?.unlockedImage
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
        profileName.text = "name"
        opponentName.text = opponent?.fname
        opponentQuote.text = "\"" + (opponent?.quote)! + "\"\n- " + (opponent?.name)!
        finalScoreLabel.text = String(finalScore)
        mainView.layer.cornerRadius = 8
        
        opponentScoreLabel.text = String((opponent?.highScore)!)
        
        setGradientBackground()
        
        //determine if the number of levels unlocked should be incremented here
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
    
}
