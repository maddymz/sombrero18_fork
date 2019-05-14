//
//  SocialMediaViewController.swift
//  Psyche
//
//  Created by psyche-admin on 5/13/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import UIKit
import WebKit

class SocialMediaViewController: UIViewController {
    
  
    @IBOutlet weak var wbView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let url = URL(string: "https://facebook.com/nasapsyche")!
        let reqObj = URLRequest(url: url)
        wbView.load(reqObj)
        
    }
    
   
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
