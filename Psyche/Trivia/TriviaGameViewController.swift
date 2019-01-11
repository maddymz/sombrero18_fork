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
    
    //Game set variables
    var category: String?
    var opponent: OpponentData?
    var profile_image = 1
    var questions :[[String]] = []
    var multiplier = 1
    
    //Game running variable
    var currentQuestion = 0
    var correctAnswer = ""
    var score = 0
    
    //timer variables
    var time = 10
    var timer = Timer()
    let shapeLayer = CAShapeLayer()
    let shapeLayer2 = CAShapeLayer()
    
    //Top Bar Outlets
    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var gradient: UIImageView!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    
    //Question assets
    @IBOutlet weak var questionCard: UIImageView!
    @IBOutlet weak var questionCardsBack: UIImageView!
    @IBOutlet weak var questionNo: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    

    // countdown clock
    @IBOutlet weak var timerLabel: UILabel!
    
    @objc func startAction() {
        if (time > 0) {
            time -= 1
            timerLabel.text = "\(time)"
        } else {
            runAnimatePause()
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
                    self.questionNo.text = "Incorrect"
                    
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
                        //show correct answer for two seconds
                        sleep(2)
                        if(self.currentQuestion != self.questions.count){
                            self.newQuestion()
                            self.runAnimate()
                        }
                        else{
                            self.performSegue(withIdentifier: "showScore", sender: self)
                        }
                    }
                }
            }
        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        runAnimate()
    }
    
    @objc private func runAnimate() {
        shapeLayer2.strokeColor = UIColor.clear.cgColor
        timer.invalidate()
        
        time = 10
        timerLabel.text = "10"
        
        timer = Timer.scheduledTimer(timeInterval: 0.999, target: self, selector: #selector(TriviaGameViewController.startAction), userInfo: nil, repeats: true)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = 10
        shapeLayer.add(basicAnimation, forKey: "basic")
        
    }
    
    @objc private func runAnimatePause() {
        var eEndAngle = -1.5706795
        if (time == 9) {
            eEndAngle = -0.9423609692828735
        } else if (time == 8) {
            eEndAngle = -0.3140424385664735
        } else if (time == 7) {
            eEndAngle = 0.3142760921499265
        } else if (time == 6) {
            eEndAngle = 0.9425946228663266
        } else if (time == 5) {
            eEndAngle = 1.570913153582727
        } else if (time == 4) {
            eEndAngle = 2.199231684297381
        } else if (time == 3) {
            eEndAngle = 2.827550215013781
        } else if (time == 2) {
            eEndAngle = 3.455868745730181
        } else if (time == 1) {
            eEndAngle = 4.084187276446581
        } else if (time < 1) {
            eEndAngle = 4.712505807162981
        }
        
        let center = CGPoint(x: 187, y: 60)
        let circularPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -CGFloat.pi / 2, endAngle: CGFloat(eEndAngle), clockwise: false)
        
        // create circle layer
        shapeLayer2.path = circularPath.cgPath
        shapeLayer2.strokeColor = UIColor.white.cgColor
        shapeLayer2.lineWidth = 7
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineCap = kCALineCapRound
        shapeLayer2.strokeEnd = 1
        
        view.layer.addSublayer(shapeLayer2)
        
        timer.invalidate()

    }
    // data model to hold the parsed json data: by Madhukar raj 01/11/2019
    struct QuizData: Decodable {
        var psyche1: [[String]]
        var psyche2: [[String]]
        var psyche3: [[String]]
        var psyche4: [[String]]
        var space1: [[String]]
        var space2: [[String]]
        var space3: [[String]]
        var space4: [[String]]
        var science1: [[String]]
        var science2: [[String]]
        var science3: [[String]]
        var science4: [[String]]
        var nasa1: [[String]]
        var nasa2: [[String]]
        var nasa3: [[String]]
        var nasa4: [[String]]
    }
    var quizDict = [String: [[String]]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // countdown clock
        let center = CGPoint(x: view.frame.width/2, y: 60)
        
        // create track layer
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -CGFloat.pi / 2, endAngle: -1.5706795, clockwise: false)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(red: 230/255.5, green: 230/255.5, blue: 230/255.5, alpha: 0.3).cgColor
        trackLayer.lineWidth = 3
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        
        view.layer.addSublayer(trackLayer)
        
        // create circle layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 7
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeEnd = 1
        
        view.layer.addSublayer(shapeLayer)

        
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
                    profileName.text = username
                } else {
                    print("no username")
                }
                
                // Get avatar
                if let avatar = result.value(forKey: "avatar") as? Int {
                    profile_image = avatar
                } else {
                    print("no avatar")
                }
            }
        } catch let error {
            print("fetch error:", error)
        }
        // parse the quiz data from json : by madhukar raj 01/11/2019
        if let quizUrl = Bundle.main.url(forResource: "Quiz", withExtension: "json", subdirectory: "/Data"){
            do {
                let quizJsonData = try Data(contentsOf: quizUrl)
                let opponentDecoder  = JSONDecoder()
                let quizDecodeData = try opponentDecoder.decode([QuizData].self, from: quizJsonData)
                
                for data in quizDecodeData {
                    print("parsed quiz data:", data.psyche1)
                    quizDict = ["psyche1" : data.psyche1 , "psyche2" : data.psyche2, "psyche3" : data.psyche3, "psyche4" : data.psyche4,
                    "nasa1" : data.nasa1, "nasa2" : data.nasa2, "nasa3" : data.nasa3, "nasa4" : data.nasa4,
                    "space1" : data.space1, "space2" : data.space2, "space3" : data.space3,"space4" : data.space4,
                    "science1" : data.science1, "science2" : data.science2, "science3" : data.science3, "science4" : data.science4]
                }
            }catch let parseError {
                print("quiz parsing error:", parseError)
            }
        }
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
        self.questions = quizDict[category! + String(opponent!.difficulty)]!
        
        if(opponent?.difficulty == 1){
            multiplier = 5
        }
        else if(opponent?.difficulty == 2){
            multiplier = 10
        }
        else if(opponent?.difficulty == 3 || opponent?.difficulty == 4){
            multiplier = 10
        }
        
        opponentScoreLabel.text = String((opponent?.highScore)!)
        
        //start game with new question
        newQuestion()
    }
    
    func newQuestion(){

        //set up question visuals
        answer1.layer.borderWidth = 1
        answer2.layer.borderWidth = 1
        answer3.layer.borderWidth = 1
        answer4.layer.borderWidth = 1
        answer1.layer.borderColor = UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1).cgColor
        answer2.layer.borderColor = UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1).cgColor
        answer3.layer.borderColor = UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1).cgColor
        answer4.layer.borderColor = UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1).cgColor
        answer1.setTitleColor(UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1), for: .normal)
        answer2.setTitleColor(UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1), for: .normal)
        answer3.setTitleColor(UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1), for: .normal)
        answer4.setTitleColor(UIColor(red:162/255, green:162/255, blue:162/255, alpha: 1), for: .normal)
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
        
        //update card back image
        if(currentQuestion == 8){
            UIView.transition(with: questionCardsBack, duration: 0.5, options: .transitionCrossDissolve, animations:{
                self.questionCardsBack.image = #imageLiteral(resourceName: "QuestionCards_Middle Card")
                })
        }
        else if (currentQuestion == 9){
            UIView.animate(withDuration: 0.5, animations: {
                self.questionCardsBack.alpha = 0
            })
        }

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
        runAnimate()
        //}
    }
    
    @IBAction func action(_ sender: AnyObject){
        runAnimatePause()
        
        let chosenButton = sender as! UIButton
        
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
                    self.questionNo.text = "Correct! +" + String(Int(self.timerLabel.text!)! * self.multiplier)
                    //change 5 to the amount of time left of timer ALSO CHECK LINE 212
                    self.score += Int(self.timerLabel.text!)! * self.multiplier
                    self.playerScoreLabel.text = String(self.score)
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
    
