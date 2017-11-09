//
//  ViewController.swift
//  Countdown
//
//  Created by Joshua on 11/8/17.
//  Copyright © 2017 NASA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var launchDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLaunchDate()
        initTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel)
    }

    // Updates timerLabel and daysLabel with the time until launch date
    func updateTimerLabel(t: Timer) {
        var diff = Int(launchDate.timeIntervalSince(Date.init()))
        
        let days = diff / 86400 // 86400 = 60 * 60 * 24
        diff -= days * 86400
        let hours = diff / 3600 // 3600 = 60 * 60
        diff -= hours * 3600
        let minutes = diff / 60
        diff -= minutes * 60
        let seconds = diff
        
        daysLabel.text = "\(days)"
        timerLabel.text = String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }

    // Initializes launch date, not really sure what it is yet. NASA website said summer of 2022?
    func setLaunchDate() {
        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 7
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "CST")
        dateComponents.hour = 9
        dateComponents.minute = 0
        
        launchDate = Calendar.current.date(from: dateComponents)!
    }
}

