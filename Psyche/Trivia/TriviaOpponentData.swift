//
//  TriviaOpponentData.swift
//  TriviaTest
//
//  Created by Julia Liu on 3/28/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation
import UIKit

//written by madhukar on 1/11/19
struct OpponentData: Decodable {
    var name: String
    var difficulty: Int //1 to 4
    var highScore: Int
    var lockedImage: String
    var unlockedImage: String
    var blurb : String
    var quote : String
    var profession: String
    var fname: String
    var level : Int
}

//this class parses the opponent json data
class Opponent {
    var oppData = [OpponentData]()
    init(){
        if let urlData = Bundle.main.url(forResource: "Opponent", withExtension: "json", subdirectory:"/Data")
        {
            do {
                let oppJsonData = try Data(contentsOf: urlData)
                let opponentDecoder  = JSONDecoder()
                let oppDecodData = try opponentDecoder.decode([OpponentData].self, from: oppJsonData)
                
                for data in oppDecodData {
                    oppData.append(data)
                    
                }
                print("parsed data:", oppData)
            }catch let parsingError {
                print("parsing error: ", parsingError)
            }
        }
    }
}




