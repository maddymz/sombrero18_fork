//
//  DisclaimerHomeViewController.swift
//  Psyche
//
//  Created by psyche-admin on 10/28/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Foundation
import UIKit

class DisclaimerHomeViewController: UIViewController {
    
    struct DisclaimerStruct: Decodable {
        let disclaimer: String
    }
    
    var disclaimerData = [DisclaimerStruct]()
    
    
    override func viewDidLoad() {
        //parse json from Disclaimer.json
        if let disclamerDataUrl = Bundle.main.url(forResource: "Disclaimer", withExtension: "json", subdirectory: "/Data"){
            do {
                let data = try Data(contentsOf: disclamerDataUrl)
                let disclaimerDecoder = JSONDecoder()
                let discalaimerDecodedData =  try disclaimerDecoder.decode(DisclaimerStruct.self, from: data)
                disclaimerData = [discalaimerDecodedData]
                
                print(" decoded data ", disclaimerData)
            }catch let parseError {
                print("Error in parsing json:", parseError)
            }
        }
    }
}
