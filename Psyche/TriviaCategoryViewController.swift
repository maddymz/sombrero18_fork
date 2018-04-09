//
//  TriviaCategoryViewController.swift
//  Psyche
//
//  Created by Julia Liu on 4/4/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit

class TriviaCategoryViewController: UIViewController {

    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    
    @IBOutlet weak var opponentBlurb: UILabel!
    
    
    var opponent: Opponent?
    var profile_image = 1
    
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
        opponentBlurb.text = opponent?.blurb
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let receiver = segue.destination as! TriviaGameViewController
        receiver.opponent = opponent
        
        if (segue.identifier == "psycheSegue"){
            receiver.category = "psyche"
        }
        else if(segue.identifier == "scienceSegue"){
            receiver.category = "science"
        }
        else if(segue.identifier == "nasaSegue"){
            receiver.category = "nasa"
        }
        else{
            receiver.category = "space"
        }
    }

}
