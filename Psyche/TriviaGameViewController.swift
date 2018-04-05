//
//  TriviaGameViewController.swift
//  Psyche
//
//  Created by Julia Liu on 4/4/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit

class TriviaGameViewController: UIViewController {

    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    
    var category: String?
    var opponent: Opponent?
    var profile_image = 1
    
    //question variables
    @IBOutlet weak var questionNo: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    
    
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
        
        startGame()
    }
    
    func startGame(){
        //start Game
        for i in 1...10{
            //get question
            //start timer
            //wait for user to make choice or times up
            //flip card animation???? https://www.youtube.com/watch?v=4kSLbuB-MlU
            //add to score
        }
        
        //reset new high score if score is higher
    }

}
    
