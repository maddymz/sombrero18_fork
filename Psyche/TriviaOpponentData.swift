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
        
        opponents.append(Opponent(name: "Neil deGrasse Tyson", difficulty: 1, highScore: 98, lockedImage: #imageLiteral(resourceName: "SallyRideLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilDTyson")))
        opponents.append(Opponent(name: "Sally Ride", difficulty: 1, highScore: 112, lockedImage: #imageLiteral(resourceName: "SallyRideLockBW"), unlockedImage: #imageLiteral(resourceName: "SallyRideGradient")))
        opponents.append(Opponent(name: "Edwin Hubble", difficulty: 2, highScore: 237, lockedImage: #imageLiteral(resourceName: "EdwinHubbleLockBW"), unlockedImage: #imageLiteral(resourceName: "EdwinHubbleGradient")))
        opponents.append(Opponent(name: "Neil Armstrong", difficulty: 2, highScore: 425, lockedImage: #imageLiteral(resourceName: "NeilArmstrongLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilArmstrongGradient")))
        opponents.append(Opponent(name: "Katherine Johnson", difficulty: 3, highScore: 728, lockedImage: #imageLiteral(resourceName: "KatherineJohnsonLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilDTyson")))
        opponents.append(Opponent(name: "Galileo", difficulty: 4, highScore: 125, lockedImage: #imageLiteral(resourceName: "GalileoLockBW"), unlockedImage: #imageLiteral(resourceName: "NeilDTyson")))
    }
}

class Opponent{
    var name: String
    var difficulty: Int //1 to 4
    var highScore: Int
    var lockedImage: UIImage
    var unlockedImage: UIImage
    
    init(name: String, difficulty: Int, highScore: Int, lockedImage: UIImage, unlockedImage: UIImage){
        self.name = name
        self.difficulty = difficulty
        self.highScore = highScore
        self.lockedImage = lockedImage
        self.unlockedImage = unlockedImage
    }
}
