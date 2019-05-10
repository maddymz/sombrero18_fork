//
//  CountdownClockTimeline.swift
//  Psyche
//
//  Created by Joshua on 4/11/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import Foundation

class CountdownClockTimeline : UIView {
    
    var phaseImg = UIImageView()
    var phaseMLabel = UILabel()
    var daysLabel = UILabel()
    var daysMLabel = UILabel()
    var timerLabel = UILabel()
    var timerMLabel = UILabel()
    var secondsMLabel = UILabel()
    
    var phases: [(phase: String, startDate: Date, endDate: Date)] = [] // Array of tuples
    var currentDateIndex = 0 // Index of date being displayed
    
    weak var countdownTimer: Timer? // Timer that ticks every second and updates the label
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialize imageview and labels
        phaseImg.frame = CGRect(x: 15, y: 14, width: 25, height: 25)
        phaseMLabel.frame = CGRect(x: 15, y: 41, width: 40, height: 21)
        phaseMLabel.text = "PHASE"
        
        let width = Int(self.frame.width)
        
        let space = (width - 15 * 2 - 25 - 164 - 82) / 3
        
        daysLabel.frame = CGRect(x: 40 + space * 2 + 10, y: 9, width: 100, height: 33)
        
        daysMLabel.frame = CGRect(x: 40 + space + 10, y: 41, width: 110, height: 21)
        daysMLabel.text = "DAYS TO NEXT PHASE"
        
        timerLabel.frame = CGRect(x: 40 + space * 2 + 82 + space, y: 11, width: 176, height: 29)
        
        timerMLabel.frame = CGRect(x: 40 + space * 2 + 82 + space + 2, y: 41, width: 110, height: 21)
        timerMLabel.text = "HOURS     MINUTES"
        
        secondsMLabel.frame = CGRect(x: 317, y: 41, width: 50, height: 21)
        secondsMLabel.text = "SECONDS"
        
        daysLabel.font = UIFont(name: "Roboto Mono", size: 34)
        daysMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        timerLabel.font = UIFont(name: "Roboto Mono", size: 34)
        timerMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        secondsMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        phaseMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        
        phaseMLabel.textColor = UIColor.white
        daysLabel.textColor = UIColor.white
        daysMLabel.textColor = UIColor.white
        timerLabel.textColor = UIColor.white
        timerMLabel.textColor = UIColor.white
        secondsMLabel.textColor = UIColor.white
        phaseMLabel.textColor = UIColor.white
        
        self.addSubview(phaseImg)
        self.addSubview(phaseMLabel)
        self.addSubview(daysLabel)
        self.addSubview(daysMLabel)
        self.addSubview(timerLabel)
        self.addSubview(timerMLabel)
        self.addSubview(secondsMLabel)
        
        addDates() // Add phases to phases array
        
        updatePhaseImg()
        
        initTimer()
        countdownTimer?.fire() // Trigger timer right away, otherwise there is a 1 second delay
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePhaseImg() {
        let phase = phases[currentDateIndex].0
        phaseImg.image = UIImage(named: "Phase_\(phase)")
    }
    
    // Adds countdown dates to phases array
    func addDates() {
        
        /*
         BUILD - phase C May 2019
         ASSEMBLY - phase D Jan 2021
         LAUNCH - phase D Aug 2022
         MARS ASSIST - phase E May 2023
         ARRIVAL - phase E Jan 2026
         ORBITING - phase E Jan 2026
         CLOSEOUT - phase F Nov 2027
         */
        
        var startDateComponents = DateComponents()
        var endDateComponents = DateComponents()
        startDateComponents.year = 2017
        startDateComponents.month = 1
        startDateComponents.day = 1
        endDateComponents.year = 2019
        endDateComponents.month = 5
        endDateComponents.day = 24
        startDateComponents.timeZone = TimeZone(abbreviation: "CST")
        startDateComponents.hour = 0
        startDateComponents.minute = 0
        phases.append(("B", Calendar.current.date(from: startDateComponents)!, Calendar.current.date(from: endDateComponents)!))
        
        startDateComponents.year = 2019
        startDateComponents.month = 5
        startDateComponents.day = 25
        endDateComponents.year = 2021
        endDateComponents.month = 1
        endDateComponents.day = 21
        phases.append(("C", Calendar.current.date(from: startDateComponents)!, Calendar.current.date(from: endDateComponents)!))
        
        startDateComponents.year = 2021
        startDateComponents.month = 1
        startDateComponents.day = 22
        endDateComponents.year = 2022
        endDateComponents.month = 9
        endDateComponents.day = 30
        phases.append(("D", Calendar.current.date(from: startDateComponents)!, Calendar.current.date(from: endDateComponents)!))
        
        startDateComponents.year = 2022
        startDateComponents.month = 10
        startDateComponents.day = 1
        endDateComponents.year = 2027
        endDateComponents.month = 10
        endDateComponents.day = 31
        phases.append(("E", Calendar.current.date(from: startDateComponents)!, Calendar.current.date(from: endDateComponents)!))
        
        startDateComponents.year = 2027
        startDateComponents.month = 11
        startDateComponents.day = 1
        endDateComponents.year = 2028
        endDateComponents.month = 8
        endDateComponents.day = 1
        phases.append(("F", Calendar.current.date(from: startDateComponents)!, Calendar.current.date(from: endDateComponents)!))
        print("phases", phases)
        
        let date = Date() // Current date
        print("date", date)
        // Remove all phases that already passed
        for i in 0 ..< phases.count - 1 {
            if phases[i].1 < date {
                phases.remove(at: i)
            }
        }
    }
    
    // Initialize countdown clock
    func initTimer() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel)
        RunLoop.current.add(countdownTimer!, forMode: .commonModes)
    }
    
    // Updates all the timer labels
    func updateTimerLabel(t: Timer) {
        var diff = Int(phases[currentDateIndex].1.timeIntervalSince(Date.init()))
        
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
    
    // Update the countdown clock
    func changeCountdown(phase: String, date: String) {
        let index = phase.index(phase.startIndex, offsetBy: phase.count - 1) // Index of last character
        let phaseStr = String(phase[index]) // Phase character, like "A"
        
        for i in 0 ... phases.count - 1 {
            if phases[i].0 == phaseStr {
                currentDateIndex = i
                updatePhaseImg()
                countdownTimer?.fire() // Trigger timer right away, otherwise there is a 1 second delay
                break
            }
        }
    }
}


