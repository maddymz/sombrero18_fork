//
//  sideMenuHelper.swift
//  Psyche
//
//  Created by Julia Liu on 4/5/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation
import UIKit

class menuHelper{
    static func notification(){
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
        })
    }
    
    static func contactUs(){
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
        })
    }
    
    static func partners(){
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
        })
    }
    
    static func getInvolved(){
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
        })
    }
    
    static func blog(){
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
        })
    }
    
    static func termsConditions(){
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
        })
    }
    
    static func openYoutube(){
        let YoutubeUser =  "UC2BGcbPW8mxryXnjQcBqk6A"
        let appURL = NSURL(string: "youtube://www.youtube.com/user/\(YoutubeUser)")!
        let webURL = NSURL(string: "https://www.youtube.com/channel/\(YoutubeUser)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
    static func openTwitter(){
        let screenName =  "nasapsyche"
        let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = NSURL(string: "https://twitter.com/\(screenName)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
    }
    
    static func openFB(){
        let Username =  "nasapsyche" // Your Instagram Username here
        let appURL = NSURL(string: "fb://profile/\(Username)")!
        let webURL = NSURL(string: "https://facebook.com/\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
    static func openInsta(){
        let Username =  "nasapsyche" // Your Instagram Username here
        let appURL = NSURL(string: "instagram://user?username=\(Username)")!
        let webURL = NSURL(string: "https://instagram.com/\(Username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Instagram app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
}
