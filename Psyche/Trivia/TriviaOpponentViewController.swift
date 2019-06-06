//
//  TriviaOpponentViewController.swift
//  TriviaTest
//
//  Created by Julia Liu on 3/28/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import CoreData

class TriviaOpponentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var profile_image = 1
    @IBOutlet weak var profile: UIImageView!
    var level = 4
    
    // Data model: These strings will be the data for the table view cells
    let opponentList = Opponent()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var gradient: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerHighScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("opponent data:", opponentList.oppData)
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
                    nameLabel.text = username
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
                    playerHighScore.text = String(highScore)
                    
                } else {
                    print("no high score")
                }
                
                if let levels_unlocked = result.value(forKey: "levels_unlocked") as? Int {
                    print(levels_unlocked)
                    level = levels_unlocked
                    
                } else {
                    print("no high score")
                }
            }
        } catch {
            
        }
        
        
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
        return self.opponentList.oppData.count + 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "emptyCell") as! UITableViewCell!
            return cell
        }
        else{
            let opponent = opponentList.oppData[indexPath.row-1]
            
            if(indexPath.row-1 < level){
                let cell:UnlockedTriviaOpponentTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "UnlockedOpponentCell") as! UnlockedTriviaOpponentTableViewCell!
                cell.setOpponent(opponent: opponent)
                cell.playButton.tag = indexPath.row-1
                return cell
            }
            else{
                let cell:LockedTriviaOpponentTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LockedOpponentCell") as! LockedTriviaOpponentTableViewCell!
                if(indexPath.row-1 == level){
                    cell.backgroundView = UIImageView.init(image: UIImage.init(named: "FakeShadowRectangle"))
                }
                cell.setOpponent(opponent: opponent)
                return cell
            }
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
                receiver.opponent = opponentList.oppData[sender.tag]
        }

    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }

    @IBAction func openNASA(_ sender: Any) {
        menuHelper.openNASA(vc: self)
    }
}
