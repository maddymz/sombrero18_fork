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
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    
    var category: String?
    var opponent: Opponent?
    var profile_image = 1
    var questions :[[String]] = []
    
    //question labels
    @IBOutlet weak var questionNo: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    //game running variable
    var currentQuestion = 0
    var correctAnswer = ""
    var score = 0
    
    //for debugging purposes
    @IBOutlet weak var scoreLabel: UILabel!
    
    
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
        self.questions = myDict[category! + String(opponent!.difficulty)]!
        
        newQuestion()
    }
    
    func newQuestion(){
        questionNo.text = "Question: " + String(currentQuestion+1)
        question.text = questions[currentQuestion][0]
        
        //correct answer
        self.correctAnswer = questions[currentQuestion][questions[currentQuestion].count - 1]
        
        //check if question contains 2 or 4 answers
        if(questions[currentQuestion].count == 6)
        {
            //ensure all answers are visible
            answer1.isHidden = false
            answer2.isHidden = false
            answer3.isHidden = false
            answer4.isHidden = false
            
            answer1.setTitle(questions[currentQuestion][1], for: .normal)
            answer2.setTitle(questions[currentQuestion][2], for: .normal)
            answer3.setTitle(questions[currentQuestion][3], for: .normal)
            answer4.setTitle(questions[currentQuestion][4], for: .normal)
            
        }
        else if(questions[currentQuestion].count == 4){
            //ensure only two answers are visible
            answer1.isHidden = false
            answer2.isHidden = false
            answer3.isHidden = true
            answer4.isHidden = true
            
            answer1.setTitle(questions[currentQuestion][1], for: .normal)
            answer2.setTitle(questions[currentQuestion][2], for: .normal)
            answer3.setTitle("", for: .normal)
            answer4.setTitle("", for: .normal)
        }
        
        //sets up for next Question
        currentQuestion += 1
    }
    
    @IBAction func action(_ sender: AnyObject){
        if(String(sender.tag) == correctAnswer ){
            score += 1
            scoreLabel.text = String(score)
        }
    
        if(currentQuestion != questions.count){
            newQuestion()
        }
        else{
            performSegue(withIdentifier: "showScore", sender: self)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showScore"){
            let receiver = segue.destination as! TriviaFinalViewController
            
            receiver.opponent = opponent
            receiver.finalScore = score
            receiver.category = category

        }
    }
}
    
