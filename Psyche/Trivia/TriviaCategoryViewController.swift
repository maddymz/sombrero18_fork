//
//  TriviaCategoryViewController.swift
//  Psyche
//
//  Created by Julia Liu on 4/4/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import CoreData

class TriviaCategoryViewController: UIViewController {

    //Opponent and Player outlets
    @IBOutlet weak var opponentAvatar: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var opponentBlurb: UILabel!
    
    //Category buttons
    @IBOutlet weak var scienceButton: UIButton!
    @IBOutlet weak var psycheButton: UIButton!
    @IBOutlet weak var nasaButton: UIButton!
    @IBOutlet weak var spaceButton: UIButton!
    
    //Opponent passed in through segue
    var opponent: OpponentData?
    
    //Image chosen by user, will be updated in core date in viewDidLoad
    var profile_image = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrieve from coredata
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
                    profileName.text = username
                } else {
                    print("no username")
                }
                
                // Get avatar
                if let avatar = result.value(forKey: "avatar") as? Int {
                    profile_image = avatar
                } else {
                    print("no avatar")
                }
            }
        } catch {
            
        }
        
        //set player and opponent
        opponentAvatar.image = UIImage(named: (opponent?.unlockedImage)!)
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
        opponentName.text = opponent?.fname
        opponentBlurb.text = opponent?.blurb
        
        screenLayout()
    }
    
    
    // handle screen layout - by Madhukar Raj , 06/06/2019
    func screenLayout(){
        
        let guide = view.safeAreaLayoutGuide
        scienceButton.translatesAutoresizingMaskIntoConstraints = false
        psycheButton.translatesAutoresizingMaskIntoConstraints = false
        nasaButton.translatesAutoresizingMaskIntoConstraints = false
        spaceButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        if UIDevice.current.screenType == .iPhone_XR{
            scienceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            scienceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            psycheButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            psycheButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            nasaButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            nasaButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            spaceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            spaceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            scienceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            scienceButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            nasaButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 600).isActive = true
            nasaButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            psycheButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            psycheButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
            spaceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 600).isActive = true
            spaceButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
           
        } else if UIDevice.current.screenType == .iPhone_XSMax {
            scienceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            scienceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            psycheButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            psycheButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            nasaButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            nasaButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            spaceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            spaceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            scienceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            scienceButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            nasaButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 600).isActive = true
            nasaButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            psycheButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            psycheButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
            spaceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 600).isActive = true
            spaceButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true

            
        } else if UIDevice.current.screenType == .iPhones_X_XS {
            scienceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            scienceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            psycheButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            psycheButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            nasaButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            nasaButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            spaceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            spaceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            scienceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            scienceButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            nasaButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 550).isActive = true
            nasaButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            psycheButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            psycheButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
            spaceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 550).isActive = true
            spaceButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
        } else if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            scienceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            scienceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            psycheButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            psycheButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            nasaButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            nasaButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            spaceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            spaceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            scienceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            scienceButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            nasaButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 550).isActive = true
            nasaButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            psycheButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            psycheButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
            spaceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 550).isActive = true
            spaceButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
        }else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
            scienceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            scienceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            psycheButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            psycheButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            nasaButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            nasaButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            spaceButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
            spaceButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
            scienceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            scienceButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            nasaButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 550).isActive = true
            nasaButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
            psycheButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 361).isActive = true
            psycheButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
            spaceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 550).isActive = true
            spaceButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30).isActive = true
            
        }else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            profile.translatesAutoresizingMaskIntoConstraints = false
            profileName.translatesAutoresizingMaskIntoConstraints = false
            opponentAvatar.translatesAutoresizingMaskIntoConstraints = false
            opponentName.translatesAutoresizingMaskIntoConstraints = false
            opponentBlurb.translatesAutoresizingMaskIntoConstraints = false
            scienceButton.heightAnchor.constraint(equalToConstant: 155).isActive = true
            scienceButton.widthAnchor.constraint(equalToConstant: 136).isActive = true
            psycheButton.heightAnchor.constraint(equalToConstant: 155).isActive = true
            psycheButton.widthAnchor.constraint(equalToConstant: 136).isActive = true
            nasaButton.heightAnchor.constraint(equalToConstant: 155).isActive = true
            nasaButton.widthAnchor.constraint(equalToConstant: 136).isActive = true
            spaceButton.heightAnchor.constraint(equalToConstant: 155).isActive = true
            spaceButton.widthAnchor.constraint(equalToConstant: 136).isActive = true
            scienceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 310).isActive = true
            scienceButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 25).isActive = true
            nasaButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 460).isActive = true
            nasaButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 25).isActive = true
            psycheButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 310).isActive = true
            psycheButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -25).isActive = true
            spaceButton.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: 460).isActive = true
            spaceButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -25).isActive = true
            opponentAvatar.widthAnchor.constraint(equalToConstant: 130).isActive = true
            opponentAvatar.heightAnchor.constraint(equalToConstant: 130).isActive = true
            opponentAvatar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
            opponentAvatar.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
            opponentName.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150).isActive = true
            opponentName.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -60).isActive = true
            profile.widthAnchor.constraint(equalToConstant: 130).isActive = true
            profile.heightAnchor.constraint(equalToConstant: 130).isActive = true
            profile.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
            profile.topAnchor.constraint(equalTo: guide.topAnchor, constant: 15).isActive = true
            profileName.topAnchor.constraint(equalTo: guide.topAnchor, constant: 150).isActive = true
            profileName.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40).isActive = true
            opponentBlurb.widthAnchor.constraint(equalToConstant: 268).isActive = true
            opponentBlurb.topAnchor.constraint(equalTo: guide.topAnchor, constant: 190).isActive = true
            opponentBlurb.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //different button segues
        if (segue.identifier == "psycheSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "psyche"
            psycheButton.setImage(#imageLiteral(resourceName: "GameCards_Psyche pressed"), for: .normal)
        }
        else if(segue.identifier == "scienceSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "science"
            scienceButton.setImage(#imageLiteral(resourceName: "GameCards_Science pressed"), for: .normal)
        }
        else if(segue.identifier == "nasaSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "nasa"
            nasaButton.setImage(#imageLiteral(resourceName: "GameCards_NASA pressed"), for: .normal)
        }
        else if (segue.identifier == "spaceSegue"){
            let receiver = segue.destination as! TriviaGameViewController
            receiver.opponent = opponent
            receiver.category = "space"
            spaceButton.setImage(#imageLiteral(resourceName: "GameCards_Space pressed"), for: .normal)
        }
        
    }

}
