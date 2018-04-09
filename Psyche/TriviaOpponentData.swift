//
//  TriviaOpponentData.swift
//  TriviaTest
//
//  Created by Julia Liu on 3/28/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation
import UIKit

class Opponents{
    var opponents = [Opponent]()
    
    init(){
        
        opponents.append(Opponent(name: "Neil deGrasse Tyson", difficulty: 1, highScore: 175, lockedImage: #imageLiteral(resourceName: "SallyRideLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilDTyson"), blurb: "Neil deGrasse Tyson is an American astrophysicist, author, and science communicator. Tyson's research has focused on observations in cosmology, stellar evolution, galactic astronomy, bulges, and stellar formation.", quote: "We are part of this universe; we are in this universe, but perhaps more important than both of those facts, is that the universe is in us."))
        opponents.append(Opponent(name: "Neil Armstrong", difficulty: 1, highScore: 280, lockedImage: #imageLiteral(resourceName: "NeilArmstrongLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilArmstrongGradient"), blurb: "Neil Armstrong was an American astronaut and aeronautical engineer, and the first person to walk on the Moon.", quote: "That's one small step for a man, one giant leap for mankind."))
        opponents.append(Opponent(name: "Dr. Lindy Elkins-Tanton", difficulty: 2, highScore: 350, lockedImage: #imageLiteral(resourceName: "Dr.LindyElkins-TantonLockBW"), unlockedImage: #imageLiteral(resourceName: "Dr.LindyElkins-TantonGradient"), blurb: "Dr. Lindy Elkins-Tanton is the director of the School of Earth and Space Exploration at Arizona State University, co-chair of the Interplanetary Initiative, and she is the Principal Investigator (PI) of the Psyche mission, selected in 2017 as the 14th in NASA's Discovery program.", quote: "Think BIG, because humanity needs that."))
        opponents.append(Opponent(name: "Edwin Hubble", difficulty: 2, highScore: 560, lockedImage: #imageLiteral(resourceName: "EdwinHubbleLockBW"), unlockedImage: #imageLiteral(resourceName: "EdwinHubbleGradient"), blurb: "Hubble discovered that many objects previously thought to be clouds of dust and gas and classified as \"nebulae\" were actually galaxies beyond the Milky Way.", quote: "Equipped with his five senses, man explores the universe around him and calls the adventure Science."))
        opponents.append(Opponent(name: "Sally Ride", difficulty: 2, highScore: 740, lockedImage: #imageLiteral(resourceName: "SallyRideLockBW"), unlockedImage: #imageLiteral(resourceName: "SallyRideGradient"), blurb: "Sally Ride was an American physicist and astronaut. She joined NASA in 1978 and became the first American woman in space in 1983.", quote: "When you're getting ready to launch into space, you're sitting on a big explosion waiting to happen."))
        opponents.append(Opponent(name: "Carl Sagan", difficulty: 3, highScore: 945, lockedImage: #imageLiteral(resourceName: "SallyRideLockBW"), unlockedImage: #imageLiteral(resourceName: "SallyRideGradient"), blurb: "Carl Sagan assembled the first physical messages sent into space: the Pioneer plaque and the Voyager Golden Record, universal messages that could potentially be understood by any extraterrestrial intelligence that might find them.", quote: "Look again at that dot. That's here. That's home. That's us."))
        opponents.append(Opponent(name: "Katherine Johnson", difficulty: 3, highScore: 1080, lockedImage: #imageLiteral(resourceName: "KatherineJohnsonLockBW"), unlockedImage: #imageLiteral(resourceName: "KatherineJohnsonGradient"), blurb: "Katherine Johnson calculated the trajectories, launch windows, and emergency back-up return paths for many flights of Project Mercury, including the early NASA missions of Alan Shepard and John Glenn, and the 1969 Apollo 11 flight to the Moon. She also performed calculations for the plans for a mission to Mars.", quote: "Everything was so new - the whole idea of going into space was new and daring. There were no textbooks, so we had to write them."))
        opponents.append(Opponent(name: "Annibale de Gasparis", difficulty: 4, highScore: 1230, lockedImage: #imageLiteral(resourceName: "GalileoLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilDTyson"), blurb: "Annibale de Gasparis, an Italian astronomer, discovered visually nine asteroids, including Psyche (16).", quote: "Andiamo in un mondo interamente metal."))
    }
}

class Opponent{
    var name: String
    var difficulty: Int //1 to 4
    var highScore: Int
    var lockedImage: UIImage
    var unlockedImage: UIImage
    var blurb : String
    var quote : String
    
    init(name: String, difficulty: Int, highScore: Int, lockedImage: UIImage, unlockedImage: UIImage, blurb: String, quote:String){
        self.name = name
        self.difficulty = difficulty
        self.highScore = highScore
        self.lockedImage = lockedImage
        self.unlockedImage = unlockedImage
        self.blurb = blurb
        self.quote = quote
    }
}
