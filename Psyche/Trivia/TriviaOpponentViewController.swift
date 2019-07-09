//
//  TriviaOpponentViewController.swift
//  TriviaTest
//
//  Created by Julia Liu on 3/28/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import CoreData

class OppInfoCell: UITableViewCell {
    

}
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
    @IBOutlet weak var highScoretext: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nasaLogo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("opponent data:", opponentList.oppData)
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
//                    playerHighScore.text = String(highScore)
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
        
        screenLayout()
    }
    
    
    // handle screen layout - by Madhukar Raj , 06/06/2019
    func screenLayout(){
        
        let guide = view.safeAreaLayoutGuide
        profile.translatesAutoresizingMaskIntoConstraints = false
        
        self.nasaLogo.translatesAutoresizingMaskIntoConstraints = true
        self.backButton.translatesAutoresizingMaskIntoConstraints = true

        if UIDevice.current.screenType == .iPhone_XR{
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.backButton.translatesAutoresizingMaskIntoConstraints = false
            profile.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 152).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 148).isActive = true
            profile.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 5).isActive = true
            backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            backButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: -15).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        } else if UIDevice.current.screenType == .iPhone_XSMax {
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.backButton.translatesAutoresizingMaskIntoConstraints = false
            profile.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 152).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 148).isActive = true
            profile.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 5).isActive = true
            backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            backButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: -15).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        } else if UIDevice.current.screenType == .iPhones_X_XS {
            self.nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            self.backButton.translatesAutoresizingMaskIntoConstraints = false
            profile.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 152).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 148).isActive = true
            profile.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 5).isActive = true
            backButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            backButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: guide.topAnchor, constant: -15).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
        } else if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            profile.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 152).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 148).isActive = true
            profile.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 5).isActive = true
        }else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
            profile.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 152).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 148).isActive = true
            profile.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 5).isActive = true
        }else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            playerHighScore.translatesAutoresizingMaskIntoConstraints = false
            highScoretext.translatesAutoresizingMaskIntoConstraints = false
            profile.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 152).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 148).isActive = true
            profile.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 2).isActive = true
            playerHighScore.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 115).isActive = true
            playerHighScore.topAnchor.constraint(equalTo: guide.topAnchor, constant: 49).isActive = true
            highScoretext.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 115).isActive = true
            highScoretext.topAnchor.constraint(equalTo: guide.topAnchor, constant: 89).isActive = true
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
                
                if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
                    let guide = cell.safeAreaLayoutGuide
                    cell.playButton.translatesAutoresizingMaskIntoConstraints = false
                    cell.highScore.translatesAutoresizingMaskIntoConstraints = false
                    cell.score.translatesAutoresizingMaskIntoConstraints = false
                    cell.name.translatesAutoresizingMaskIntoConstraints = false
                    cell.name.widthAnchor.constraint(equalToConstant: 100).isActive = true
                    cell.name.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 92).isActive = true
                    cell.score.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40).isActive = true
                    cell.name.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
                    cell.highScore.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -2).isActive = true
                    cell.highScore.widthAnchor.constraint(equalToConstant: 35).isActive = true
                    cell.highScore.heightAnchor.constraint(equalToConstant: 33).isActive = true
                    cell.playButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -5).isActive = true
                    cell.playButton.widthAnchor.constraint(equalToConstant: 77).isActive = true
                    cell.playButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
                    cell.playButton.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: 20).isActive = true
                }
         
                return cell
            }
            else{
                let cell:LockedTriviaOpponentTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LockedOpponentCell") as! LockedTriviaOpponentTableViewCell!
                if(indexPath.row-1 == level){
                    cell.backgroundView = UIImageView.init(image: UIImage.init(named: "FakeShadowRectangle"))
                }
                cell.setOpponent(opponent: opponent)
                
                if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
                    let guide = cell.safeAreaLayoutGuide
                    cell.highScore.translatesAutoresizingMaskIntoConstraints = false
                    cell.score.translatesAutoresizingMaskIntoConstraints = false
                    cell.name.translatesAutoresizingMaskIntoConstraints = false
                    cell.name.widthAnchor.constraint(equalToConstant: 100).isActive = true
                    cell.name.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 92).isActive = true
                    cell.name.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
                    cell.score.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40).isActive = true
                    cell.highScore.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -2).isActive = true
                    cell.highScore.widthAnchor.constraint(equalToConstant: 35).isActive = true
                    cell.highScore.heightAnchor.constraint(equalToConstant: 33).isActive = true
                }
       
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
    
    @IBAction func back(_ sender: Any){
        performSegue(withIdentifier: "opponentToExit", sender: nil)
    }

    @IBAction func openNASA(_ sender: Any) {
        menuHelper.openNASA(vc: self)
    }
}
