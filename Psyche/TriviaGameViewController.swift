//
//  TriviaGameViewController.swift
//  Psyche
//
//  Created by Julia Liu on 4/4/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import CoreData

class TriviaGameViewController: UIViewController {

    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var questionCard: UIImageView!
    @IBOutlet weak var gradient: UIImageView!
    
    
    
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
                } else {
                    print("no high score")
                }
            }
        } catch {
            
        }
        
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
        self.questions = myDict[category! + String(opponent!.difficulty)]!
        
        newQuestion()
    }
    
    func newQuestion(){
        //set up question visuals
        answer1.layer.borderWidth = 1
        answer2.layer.borderWidth = 1
        answer3.layer.borderWidth = 1
        answer4.layer.borderWidth = 1
        answer1.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        answer2.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        answer3.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        answer4.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        answer1.setTitleColor(UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1), for: .normal)
        answer2.setTitleColor(UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1), for: .normal)
        answer3.setTitleColor(UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1), for: .normal)
        answer4.setTitleColor(UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1), for: .normal)
        answer1.backgroundColor = .white
        answer2.backgroundColor = .white
        answer3.backgroundColor = .white
        answer4.backgroundColor = .white
        answer1.setBackgroundImage(nil, for: .normal)
        answer2.setBackgroundImage(nil, for: .normal)
        answer3.setBackgroundImage(nil, for: .normal)
        answer4.setBackgroundImage(nil, for: .normal)
        
        //enable buttons
        self.answer1.isUserInteractionEnabled = true
        self.answer2.isUserInteractionEnabled = true
        self.answer3.isUserInteractionEnabled = true
        self.answer4.isUserInteractionEnabled = true
        
        //change question text
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
        
        var chosenButton = sender as! UIButton
        
        //CARD FLIP
        UIView.animate(withDuration: 0.4, animations: {
            //hide all elements for card flip
            self.questionNo.alpha = 0
            self.question.alpha = 0
            self.answer1.alpha = 0
            self.answer2.alpha = 0
            self.answer3.alpha = 0
            self.answer4.alpha = 0
        }) { (success) in
            //card flip
            UIView.animate(withDuration: 0.5, animations: {
                UIView.transition(with: self.questionCard, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            }) { (success) in
                //sleep for 0.5 seconds
                usleep(500000)
                //change the question labels
                if(String(sender.tag) == self.correctAnswer ){
                    self.questionNo.text = "Correct! +" + String(1)
                }
                else{
                    self.questionNo.text = "Incorrect"
                    chosenButton.backgroundColor = UIColor( red: CGFloat(162/255.0), green: CGFloat(162/255.0), blue: CGFloat(162/255.0), alpha: CGFloat(1.0) )
                    chosenButton.setTitleColor(.white, for: .normal)
                }
                
                //highlight correct answer
                if(String(self.answer1.tag) == self.correctAnswer ){
                    self.answer1.setBackgroundImage(#imageLiteral(resourceName: "CorrectButtonFill"), for: .normal)
                    self.answer1.setTitleColor(.white, for: .normal)
                    self.answer1.layer.borderWidth = 0
                }
                else if(String(self.answer2.tag) == self.correctAnswer){
                    self.answer2.setBackgroundImage(#imageLiteral(resourceName: "CorrectButtonFill"), for: .normal)
                    self.answer2.setTitleColor(.white, for: .normal)
                    self.answer2.layer.borderWidth = 0
                }
                else if(String(self.answer3.tag) == self.correctAnswer){
                    self.answer3.setBackgroundImage(#imageLiteral(resourceName: "CorrectButtonFill"), for: .normal)
                    self.answer3.setTitleColor(.white, for: .normal)
                    self.answer3.layer.borderWidth = 0
                }
                else if(String(self.answer4.tag) == self.correctAnswer){
                    self.answer4.setBackgroundImage(#imageLiteral(resourceName: "CorrectButtonFill"), for: .normal)
                    self.answer4.setTitleColor(.white, for: .normal)
                    self.answer4.layer.borderWidth = 0
                }
                
                //disable buttons
                self.answer1.isUserInteractionEnabled = false
                self.answer2.isUserInteractionEnabled = false
                self.answer3.isUserInteractionEnabled = false
                self.answer4.isUserInteractionEnabled = false
                
                //make question and buttons visible again
                UIView.animate(withDuration: 0.5, animations: {
                    self.questionNo.alpha = 1
                    self.question.alpha = 1
                    self.answer1.alpha = 1
                    self.answer2.alpha = 1
                    self.answer3.alpha = 1
                    self.answer4.alpha = 1
                }) { (success) in
                    
                    sleep(2)
                    if(self.currentQuestion != self.questions.count){
                        self.newQuestion()
                    }
                    else{
                        self.performSegue(withIdentifier: "showScore", sender: self)
                    }
                }
            }
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
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
}
    
