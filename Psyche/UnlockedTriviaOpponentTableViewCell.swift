//
//  UnlockedTriviaOpponentTableViewCell.swift
//  TriviaTemp
//
//  Created by Julia Liu on 4/4/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit

class UnlockedTriviaOpponentTableViewCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    func setOpponent(opponent: Opponent){
        picture.image = opponent.unlockedImage
        name.text = opponent.name
        if(opponent.difficulty == 1){
            difficulty.text = "Easy"
            levelImage.image = #imageLiteral(resourceName: "EasyIcon")
        }
        else if (opponent.difficulty == 2){
            difficulty.text = "Medium"
            levelImage.image = #imageLiteral(resourceName: "MediumIcon")
        }
        else if (opponent.difficulty == 3){
            difficulty.text = "Hard"
            levelImage.image = #imageLiteral(resourceName: "HardIcon")
        }
        else{
            difficulty.text = "Very Hard"
            levelImage.image = #imageLiteral(resourceName: "VeryHardIcon")
        }
    }


}
