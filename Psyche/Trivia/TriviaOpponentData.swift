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
        
        opponents.append(Opponent(name: "Neil deGrasse Tyson", difficulty: 1, highScore: 160, lockedImage: #imageLiteral(resourceName: "SallyRideLockBW"), unlockedImage: #imageLiteral(resourceName: "Neil_Gradient"), blurb: "Neil deGrasse Tyson is an American astrophysicist, author, and science communicator.", quote: "We are part of this universe; we are in this universe, but perhaps more important than both of those facts, is that the universe is in us.", profession: "Astrophysicist", fname: "Neil", level: 1))
        opponents.append(Opponent(name: "Neil Armstrong", difficulty: 1, highScore: 280, lockedImage: #imageLiteral(resourceName: "NeilArmstrongLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilArmstrong_Gradient"), blurb: "Neil Armstrong was an astronaut and aeronautical engineer, and first to walk on the Moon.", quote: "That's one small step for a man, one giant leap for mankind.",profession: "Astronaut", fname: "Neil",level: 2))
        opponents.append(Opponent(name: "Dr. Lindy Elkins-Tanton", difficulty: 2, highScore: 335, lockedImage: #imageLiteral(resourceName: "Lindy_Lock"), unlockedImage: #imageLiteral(resourceName: "LindyGradient"), blurb: "Dr. Lindy Elkins-Tanton is the Principal Investigator of the Psyche mission.", quote: "Think BIG, because humanity needs that.",profession: "Principal Investigator", fname: "Lindy",level: 3))
        opponents.append(Opponent(name: "Edwin Hubble", difficulty: 2, highScore: 560, lockedImage: #imageLiteral(resourceName: "EdwinHubbleLockBW"), unlockedImage: #imageLiteral(resourceName: "EdwinHubbleGradient"), blurb: "Hubble discovered that many objects previously thought to be clouds of dust and gas and classified as \"nebulae\" were actually galaxies beyond the Milky Way.", quote: "Equipped with his five senses, man explores the universe around him and calls the adventure Science.",profession: "Astronomer", fname: "Edwin", level: 4))
        opponents.append(Opponent(name: "Sally Ride", difficulty: 2, highScore: 740, lockedImage: #imageLiteral(resourceName: "SallyRideLockBW"), unlockedImage: #imageLiteral(resourceName: "Sally_Gradient"), blurb: "Sally Ride was a physicist and astronaut, and became the first American woman in space in 1983.", quote: "When you're getting ready to launch into space, you're sitting on a big explosion waiting to happen.",profession: "Astronaut", fname: "Sally", level: 5))
        opponents.append(Opponent(name: "Carl Sagan", difficulty: 3, highScore: 930, lockedImage: #imageLiteral(resourceName: "CarlSagan_Lock"), unlockedImage: #imageLiteral(resourceName: "CarlSaganGradient"), blurb: "Carl Sagan assembled the 1st physical messages sent into space: the Pioneer plaque & Golden Record.", quote: "Look again at that dot. That's here. That's home. That's us.",profession: "Astronomer", fname: "Carl", level: 6))
        opponents.append(Opponent(name: "Katherine Johnson", difficulty: 3, highScore: 1080, lockedImage: #imageLiteral(resourceName: "KatherineJohnsonLockBW"), unlockedImage: #imageLiteral(resourceName: "KatherineJohnsonGradient"), blurb: "Katherine Johnson performed many calculations for NASA, including the plans for a mission to Mars.", quote: "Everything was so new - the whole idea of going into space was new and daring. There were no textbooks, so we had to write them.",profession: "Mathematician", fname: "Katherine", level: 7))
        opponents.append(Opponent(name: "Annibale de Gasparis", difficulty: 4, highScore: 1230, lockedImage: #imageLiteral(resourceName: "AnnibaledeGasparis_Lock"), unlockedImage: #imageLiteral(resourceName: "AnnibaledeGasparisGradient"), blurb: "Annibale de Gasparis, an Italian astronomer, discovered visually Psyche (16).", quote: "Andiamo in un mondo interamente metal.",profession: "Astronomer", fname: "Annibale", level: 8))
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
    var profession: String
    var fname: String
    var level : Int
    
    init(name: String, difficulty: Int, highScore: Int, lockedImage: UIImage, unlockedImage: UIImage, blurb: String, quote:String, profession: String, fname: String, level: Int){
        self.name = name
        self.difficulty = difficulty
        self.highScore = highScore
        self.lockedImage = lockedImage
        self.unlockedImage = unlockedImage
        self.blurb = blurb
        self.quote = quote
        self.profession = profession
        self.fname = fname
        self.level = level
    }
}
