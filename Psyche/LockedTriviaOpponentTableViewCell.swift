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
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var professionLabel: UILabel!
    
    
    func setOpponent(opponent: Opponent){
        picture.image = opponent.lockedImage
        name.text = opponent.name
        if(opponent.difficulty == 1){
            difficulty.text = "Easy"
            levelImage.image = #imageLiteral(resourceName: "EasyIconBW")
        }
        else if (opponent.difficulty == 2){
            difficulty.text = "Medium"
            levelImage.image = #imageLiteral(resourceName: "MediumIconBW")
        }
        else if (opponent.difficulty == 3){
            difficulty.text = "Hard"
            levelImage.image = #imageLiteral(resourceName: "HardIconBW")
        }
        else{
            difficulty.text = "Very Hard"
            levelImage.image = #imageLiteral(resourceName: "VeryHardIconBW")
        }

        score.text = String(opponent.highScore)
        professionLabel.text = opponent.profession
    }
}
