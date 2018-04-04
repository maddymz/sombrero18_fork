//
//  TriviaOpponentTableViewCell.swift
//  TriviaTest
//
//  Created by Julia Liu on 3/28/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit

class LockedTriviaOpponentTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var score: UILabel!
    
    
    func setOpponent(opponent: Opponent){
        picture.image = opponent.lockedImage
        name.text = opponent.name
        if(opponent.difficulty == 1){
            difficulty.text = "Easy"
        }
        else if (opponent.difficulty == 2){
            difficulty.text = "Medium"
        }
        else if (opponent.difficulty == 3){
            difficulty.text = "Hard"
        }
        else{
            difficulty.text = "Very Hard"
        }
        score.text = String(opponent.highScore)
    }
}
