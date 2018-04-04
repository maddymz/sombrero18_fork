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

    func setOpponent(opponent: Opponent){
        picture.image = opponent.unlockedImage
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
    }


}
