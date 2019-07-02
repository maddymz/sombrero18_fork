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
    static func events(vc : UIViewController){
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://psyche.asu.edu/get-involved/events/")
    }
    
    static func contactUs(vc : UIViewController){
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://psyche.asu.edu/contact/")
    }
    
    static func science(vc : UIViewController){
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://psyche.asu.edu/science/")
    }
    
    static func getInvolved(vc : UIViewController){
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://psyche.asu.edu/get-involved/")
    }
    
    static func blog(vc : UIViewController){
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://psyche.asu.edu/category/blog/")
    }
    
    static func mission(vc : UIViewController){
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://psyche.asu.edu/mission/")
        
    }
    
    static func news(vc : UIViewController){
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://psyche.asu.edu/category/news/")
    }
    
    static func openYoutube(vc : UIViewController){
        let YoutubeUser =  "UC2BGcbPW8mxryXnjQcBqk6A"
        
        showWarningAlert(vc: vc, appURLStr: "youtube://www.youtube.com/user/\(YoutubeUser)", webURLStr: "https://www.youtube.com/channel/\(YoutubeUser)")
    }
    
    static func openTwitter(vc : UIViewController){
        let screenName =  "nasapsyche"
        
        showWarningAlert(vc: vc, appURLStr: "twitter://user?screen_name=\(screenName)", webURLStr: "https://twitter.com/\(screenName)")
    }
    
    static func openFB(vc: UIViewController){
        let Username =  "nasapsyche"
        
        showWarningAlert(vc: vc, appURLStr: "fb://profile/\(Username)", webURLStr: "https://facebook.com/\(Username)")
    }
    
    static func openInsta(vc : UIViewController){
        let Username =  "nasapsyche" // Your Instagram Username here
        
        showWarningAlert(vc: vc, appURLStr: "instagram://user?username=\(Username)", webURLStr: "https://instagram.com/\(Username)")
    }
    
    static func openNASA(vc: UIViewController) {
        showWarningAlert(vc: vc, appURLStr: "", webURLStr: "https://www.nasa.gov/")
    }
    
    // Try opening the app, if the app is not installed then open the website in Safari
    static func openAppOrWeb(appURLStr: String, webURLStr: String) {
        let appURL = NSURL(string: appURLStr)!
        let webURL = NSURL(string: webURLStr)!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // If app is not installed, open URL in Safari
            application.open(webURL as URL)
        }
    }
    
    static func showWarningAlert(vc: UIViewController, appURLStr: String, webURLStr: String) {
        
        var dialogMessage = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        // Declare Alert message
        if webURLStr == "https://www.nasa.gov/" {
             dialogMessage = UIAlertController(title: "Leave Psyche?", message: "This app is trying to open the NASA website. Are you sure you want to open it?", preferredStyle: .alert)

        }else {
             dialogMessage = UIAlertController(title: "Leave Psyche?", message: "This app is trying to open the Psyche website. Are you sure you want to open it?", preferredStyle: .alert)

        }
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            openAppOrWeb(appURLStr: appURLStr, webURLStr: webURLStr)
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message in ViewController passed in
        vc.present(dialogMessage, animated: true, completion: nil)
    }
    
}
