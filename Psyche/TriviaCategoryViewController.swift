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
    
    //category buttons
    @IBOutlet weak var scienceButton: UIButton!
    @IBOutlet weak var psycheButton: UIButton!
    @IBOutlet weak var nasaButton: UIButton!
    @IBOutlet weak var spaceButton: UIButton!
    
    
    var opponent: Opponent?
    var profile_image = 1
    
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
        opponentBlurb.text = opponent?.blurb
        
        scienceButton.setImage(#imageLiteral(resourceName: "GameCards_Science"), for: .normal)
        psycheButton.setImage(#imageLiteral(resourceName: "GameCards_Psyche"), for: .normal)
        nasaButton.setImage(#imageLiteral(resourceName: "GameCards_NASA"), for: .normal)
        spaceButton.setImage(#imageLiteral(resourceName: "GameCards_Space"), for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let receiver = segue.destination as! TriviaGameViewController
        receiver.opponent = opponent
        
        if (segue.identifier == "psycheSegue"){
            receiver.category = "psyche"
            psycheButton.setImage(#imageLiteral(resourceName: "GameCards_Psyche pressed"), for: .normal)
        }
        else if(segue.identifier == "scienceSegue"){
            receiver.category = "science"
            scienceButton.setImage(#imageLiteral(resourceName: "GameCards_Science pressed"), for: .normal)
        }
        else if(segue.identifier == "nasaSegue"){
            receiver.category = "nasa"
            nasaButton.setImage(#imageLiteral(resourceName: "GameCards_NASA pressed"), for: .normal)
        }
        else{
            receiver.category = "space"
            spaceButton.setImage(#imageLiteral(resourceName: "GameCards_Space pressed"), for: .normal)
        }
    }

}
