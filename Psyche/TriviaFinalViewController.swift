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
    
    @IBOutlet weak var opponentQuote: UILabel!
    var category: String?
    var opponent: Opponent?
    var profile_image = 1
    var finalScore = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        opponentAvatar.image = opponent?.unlockedImage
        if(profile_image == 1){
            profile.image = #imageLiteral(resourceName: "Trivia-Asteroid")
        }
        else if(profile_image == 2){
            profile.image = #imageLiteral(resourceName: "Trivia-Earth")
        }
        else if(profile_image == 3){
            profile.image = #imageLiteral(resourceName: "Trivia-Moon")
        }
        else if(profile_image == 4){
            profile.image = #imageLiteral(resourceName: "Trivia-Saturn")
        }
        else if(profile_image == 5){
            profile.image = #imageLiteral(resourceName: "Trivia-Star")
        }
        else if(profile_image == 6){
            profile.image = #imageLiteral(resourceName: "Trivia-Sun")
        }
        profileName.text = "name"
        opponentName.text = opponent?.name
        opponentQuote.text = "\"" + (opponent?.quote)! + "\""
        finalScoreLabel.text = "Final Score: " + String(finalScore)
        
        //determine if the number of levels unlocked should be incremented here
    }

}
