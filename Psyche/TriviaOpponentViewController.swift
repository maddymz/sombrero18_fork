//
//  TriviaOpponentViewController.swift
//  TriviaTest
//
//  Created by Julia Liu on 3/28/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
class TriviaOpponentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //THIS NEEDS TO BE CHANGED TO BE IN CORE DATA
    let profile_image = 1
    @IBOutlet weak var profile: UIImageView!
    var level = 4
    
    // Data model: These strings will be the data for the table view cells
    let opponentList = Opponents()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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


    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.opponentList.opponents.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let opponent = opponentList.opponents[indexPath.row]
        
        if(indexPath.row < level){
            let cell:UnlockedTriviaOpponentTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "UnlockedOpponentCell") as! UnlockedTriviaOpponentTableViewCell!
            cell.setOpponent(opponent: opponent)
            cell.playButton.tag = indexPath.row
            return cell
        }
        else{
            let cell:LockedTriviaOpponentTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LockedOpponentCell") as! LockedTriviaOpponentTableViewCell!
            if(indexPath.row == level){
                cell.backgroundView = UIImageView.init(image: UIImage.init(named: "FakeShadowRectangle"))
            }
            cell.setOpponent(opponent: opponent)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 85.0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame"{
                let sender = sender as! UIButton
                let receiver = segue.destination as! TriviaCategoryViewController
                receiver.opponent = opponentList.opponents[sender.tag]
        }

    }

}
