//
//  CountdownClockHome.swift
//  Psyche
//
//  Created by Joshua on 4/9/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import Foundation

// Custom class used for the dates on the drop down blur
class DateView : UIView {
    var id = 0
    var yearLabel: UILabel?
    var dayLabel: UILabel?
    var hourLabel: UILabel? // If years == 0, then this will be the timer label
}

class CountdownClockHome : UIView, UIScrollViewDelegate {
    var hvc : HomeViewController!
    
    var daysLabel = UILabel()
    var daysMLabel = UILabel()
    var timerLabel = UILabel()
    var timerMLabel = UILabel()
    var secondsMLabel = UILabel()
    var phaseImg = UIImageView()
    
    var phases: [(label: String, phase: String, date: Date)] = [] // Array of tuples
    var dateLabels = [String]() // Array of names for dates
    var currentDateIndex = 0 // Index of date being displayed
    var dateViews = [DateView]()
    
    weak var countdownTimer: Timer? // Timer that ticks every second and updates the label
    
    // Variables for the drop down blur
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
    let blurEffectView = UIVisualEffectView()
    var timeBlurYPos = 0 // Y position of blur drop down
    var timeBlurHeight = 0
    var timeBlurWidth = 0
    
    let dropdownView = UIView() // This view rests on top of the blurEffectView
    var dropdownShowing = 0 // 0 means dropdown not showing, 1 means dropdown is showing
    
    // Alignment constants for drop down
    // X positions
    let dateLabelX = 16
    let yearLabelX = 101
    let yearMLabelX = 101
    let dayLabelX = 199
    let dayMLabelX = 199
    let hourLabelX = 314
    let hourMLabelX = 314
    let secondsMLabelX = 317
    let timeMLabelXConst = 1
    
    // Y positions
    let dateLabelYConst = -20
    let timeLabelYConst = -10
    let timeMLabelYConst = 16
    let separation = 90 // Distance between the different dates
    
    init(frame: CGRect, parent: HomeViewController) {
        super.init(frame: frame)
        
        self.hvc = parent
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTap))) // Adds tap event handler
        
        // Initialize imageview and labels
        phaseImg.frame = CGRect(x: 15, y: 10, width: 40, height: 40)
        
        daysLabel.frame = CGRect(x: 101, y: 9, width: 100, height: 33)
        
        daysMLabel.frame = CGRect(x: 104, y: 41, width: 42, height: 21)
        daysMLabel.text = "DAYS"
        
        timerLabel.frame = CGRect(x: 199, y: 11, width: 176, height: 29)
        
        timerMLabel.frame = CGRect(x: 201, y: 41, width: 110, height: 21)
        timerMLabel.text = "HOURS     MINUTES"
        
        secondsMLabel.frame = CGRect(x: 317, y: 41, width: 50, height: 21)
        secondsMLabel.text = "SECONDS"
        
        daysLabel.font = UIFont(name: "Roboto Mono", size: 34)
        daysMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        timerLabel.font = UIFont(name: "Roboto Mono", size: 34)
        timerMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        secondsMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        
        daysLabel.textColor = UIColor.white
        daysMLabel.textColor = UIColor.white
        timerLabel.textColor = UIColor.white
        timerMLabel.textColor = UIColor.white
        secondsMLabel.textColor = UIColor.white
        
        self.addSubview(phaseImg)
        self.addSubview(daysLabel)
        self.addSubview(daysMLabel)
        self.addSubview(timerLabel)
        self.addSubview(timerMLabel)
        self.addSubview(secondsMLabel)
        
        // Initialize blur variables
        timeBlurYPos = Int(hvc.stackView.frame.height)
        timeBlurHeight = Int(hvc.view.bounds.height) - timeBlurYPos
        timeBlurWidth = Int(hvc.view.bounds.width)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = CGRect(x: 0, y: timeBlurYPos - timeBlurHeight, width: timeBlurWidth, height: timeBlurHeight)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dropdownView.frame = CGRect(x: 0, y: timeBlurYPos - timeBlurHeight, width: timeBlurWidth, height: timeBlurHeight)
        
        addDates() // Add phases to phases array
        
        updatePhaseImg()
        
        initTimer()
        countdownTimer?.fire() // Trigger timer right away, otherwise there is a 1 second delay
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func viewTap(sender: UITapGestureRecognizer) {
        if (dropdownShowing == 0) { // Dropdown is not showing, show
            hvc.view.addSubview(blurEffectView)
            hvc.view.addSubview(dropdownView)
            
            addCountdownLabels()
            
            hvc.stackView.layer.zPosition = 1 // So that the blur effect passes underneath
            self.layer.zPosition = 2 // Needs to be visible above stackview
            
            UIView.animate(withDuration: 0.3) {
                self.blurEffectView.frame = CGRect(x: 0, y: self.timeBlurYPos, width: self.timeBlurWidth, height: self.timeBlurHeight)
                self.dropdownView.frame = CGRect(x: 0, y: self.timeBlurYPos, width: self.timeBlurWidth, height: self.timeBlurHeight)
            }
            
            self.dropdownShowing = 1
        } else { // Dropdown is showing, unshow
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.blurEffectView.frame = CGRect(x: 0, y: self.timeBlurYPos - self.timeBlurHeight
                    , width: self.timeBlurWidth, height: self.timeBlurHeight)
                self.dropdownView.frame = CGRect(x: 0, y: self.timeBlurYPos - self.timeBlurHeight
                    , width: self.timeBlurWidth, height: self.timeBlurHeight)
                self.updatePhaseImg()
            }, completion: { (finished: Bool) in
                self.blurEffectView.removeFromSuperview()
                self.dropdownView.removeFromSuperview()
                
                self.hvc.stackView.layer.zPosition = 0
                self.layer.zPosition = 0
            })
            
            self.dropdownShowing = 0
        }
    }
    
    // Handles user tapping a different countdown date
    @objc func dateTap(sender:UITapGestureRecognizer) {
        let viewTapped = sender.view as? DateView
        
        dateViews.forEach { (dateView) in
            if (dateView.id == viewTapped?.id) {
                countdownTimer?.invalidate()
                currentDateIndex = dateView.id
                countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel)
                countdownTimer?.fire()
                
                viewTap(sender: sender)
                return
            }
        }
    }
    
    func updatePhaseImg() {
        let phase = phases[currentDateIndex].1
        phaseImg.image = UIImage(named: "Phase_\(phase)")
    }
    
    // Adds labels to blur effect view
    func addCountdownLabels() {
        var i = 0 // Counter for number of views added to the blur
        var j = 0 // Counter to loop through dates
        
        let max = phases.count - 2
        
        dateViews.forEach { (dateView) in
            dateView.removeFromSuperview()
        }
        dateViews = [DateView]() // Clear the array
        
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Int(self.bounds.width), height: separation * phases.count)
        scrollView.frame = CGRect(x: 0, y: 0, width: Int(self.bounds.width), height: Int(dropdownView.bounds.height))
        dropdownView.addSubview(scrollView)
        
        phases.forEach { (phase) in
            if (j != currentDateIndex) {
                let result = dateToString(date: phase.2)
                
                let dateView = DateView()
                dateView.frame = CGRect(x: 0, y: i * separation, width: Int(self.bounds.width), height: separation)
                let dateLabel = UILabel()
                dateLabel.frame = CGRect(x: dateLabelX, y: dateLabelYConst, width: 100, height: 100)
                
                if (result.0 != "") { // years > 0
                    let yearLabel = UILabel()
                    yearLabel.frame = CGRect(x: yearLabelX, y: timeLabelYConst, width: 100, height: 100)
                    let yearMLabel = UILabel()
                    yearMLabel.frame = CGRect(x: yearMLabelX + timeMLabelXConst, y: timeMLabelYConst, width: 100, height: 100)
                    let dayLabel = UILabel()
                    dayLabel.frame = CGRect(x: dayLabelX, y: timeLabelYConst, width: 100, height: 100)
                    let dayMLabel = UILabel()
                    dayMLabel.frame = CGRect(x: dayMLabelX + timeMLabelXConst, y: timeMLabelYConst, width: 100, height: 100)
                    let hourLabel = UILabel()
                    hourLabel.frame = CGRect(x: hourLabelX, y: timeLabelYConst, width: 100, height: 100)
                    let hourMLabel = UILabel()
                    hourMLabel.frame = CGRect(x: hourMLabelX + timeMLabelXConst, y: timeMLabelYConst, width: 100, height: 100)
                    
                    yearLabel.text = result.0
                    dayLabel.text = result.1
                    hourLabel.text = result.2
                    yearLabel.textColor = UIColor.gray
                    hourLabel.textColor = UIColor.gray
                    dayLabel.textColor = UIColor.gray
                    
                    yearMLabel.text = "YEARS"
                    dayMLabel.text = "DAYS"
                    hourMLabel.text = "HOURS"
                    yearMLabel.textColor = UIColor.gray
                    hourMLabel.textColor = UIColor.gray
                    dayMLabel.textColor = UIColor.gray
                    
                    yearLabel.font = UIFont(name: "Roboto Mono", size: 34)
                    dayLabel.font = UIFont(name: "Roboto Mono", size: 34)
                    hourLabel.font = UIFont(name: "Roboto Mono", size: 34)
                    yearMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    dayMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    hourMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    
                    dateView.addSubview(yearLabel)
                    dateView.addSubview(yearMLabel)
                    dateView.addSubview(dayLabel)
                    dateView.addSubview(dayMLabel)
                    dateView.addSubview(hourLabel)
                    dateView.addSubview(hourMLabel)
                    
                    dateView.yearLabel = yearLabel
                    dateView.dayLabel = dayLabel
                    dateView.hourLabel = hourLabel
                } else { // years == 0
                    
                    let dayLabel = UILabel()
                    dayLabel.frame = CGRect(x: yearLabelX, y: timeLabelYConst, width: 100, height: 100)
                    let dayMLabel = UILabel()
                    dayMLabel.frame = CGRect(x: yearMLabelX + timeMLabelXConst, y: timeMLabelYConst, width: 100, height: 100)
                    
                    let timeLabel = UILabel()
                    timeLabel.frame = CGRect(x: dayLabelX, y: timeLabelYConst, width: 300, height: 100)
                    let timeMLabel = UILabel()
                    timeMLabel.frame = CGRect(x: dayMLabelX + timeMLabelXConst, y: timeMLabelYConst, width: 200, height: 100)
                    let secondsMLabel = UILabel()
                    secondsMLabel.frame = CGRect(x: secondsMLabelX, y: timeMLabelYConst, width: 200, height: 100)
                    
                    dayLabel.text = result.1
                    timeLabel.text = result.2
                    timeLabel.textColor = UIColor.gray
                    dayLabel.textColor = UIColor.gray
                    
                    dayMLabel.text = "DAYS"
                    timeMLabel.text = "HOURS     MINUTES"
                    secondsMLabel.text = "SECONDS"
                    timeMLabel.textColor = UIColor.gray
                    dayMLabel.textColor = UIColor.gray
                    secondsMLabel.textColor = UIColor.gray
                    
                    timeLabel.font = UIFont(name: "Roboto Mono", size: 34)
                    dayLabel.font = UIFont(name: "Roboto Mono", size: 34)
                    timeMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    dayMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    secondsMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    
                    dateView.addSubview(timeLabel)
                    dateView.addSubview(timeMLabel)
                    dateView.addSubview(dayLabel)
                    dateView.addSubview(dayMLabel)
                    dateView.addSubview(secondsMLabel)
                    
                    dateView.dayLabel = dayLabel
                    dateView.hourLabel = timeLabel
                }
                
                dateLabel.text = phase.0
                dateLabel.textColor = UIColor.black
                dateLabel.font = dateLabel.font.withSize(10)
                dateView.addSubview(dateLabel)
                
                if (i < max) {
                    let line = UIView()
                    line.frame = CGRect(x: 16, y: timeMLabelYConst + 75, width: Int(self.bounds.width - 32), height: 1)
                    line.backgroundColor = UIColor.lightGray
                    dateView.addSubview(line)
                }
                
                dateView.isUserInteractionEnabled = true
                dateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dateTap))) // Adds tap event handler for timeBar
                
                scrollView.addSubview(dateView)
                dateView.id = j
                dateViews.append(dateView)
                
                i += 1
            }
            j += 1
        }
    }
    
    // Formats a date to a string
    func dateToString(date: Date) -> (String, String, String) {
        var tempDiff = Int(date.timeIntervalSince(Date.init())) // Number of seconds until date
        
        let years = tempDiff / 31536000 // 31536000 = 60 * 60 * 24 * 365
        tempDiff -= years * 31536000
        let days = tempDiff / 86400 // 86400 = 60 * 60 * 24
        tempDiff -= days * 86400
        let hours = tempDiff / 3600 // 3600 = 60 * 60
        
        if (years > 0) {
            return ("\(years)", "\(days)", "\(hours)")
        } else {
            tempDiff -= hours * 3600
            let minutes = tempDiff / 60
            tempDiff -= minutes * 60
            let seconds = tempDiff
            
            let time = String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
            return ("", "\(days)", "\(time)")
        }
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
        
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 5
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "CST")
        dateComponents.hour = 0
        dateComponents.minute = 0
        phases.append(("BUILD", "C", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2021
        dateComponents.month = 1
        phases.append(("ASSEMBLY", "D", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2022
        dateComponents.month = 8
        phases.append(("LAUNCH", "D", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2023
        dateComponents.month = 5
        phases.append(("MARS ASSIST", "E", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2026
        dateComponents.month = 1
        phases.append(("ARRIVAL", "E", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2026
        dateComponents.month = 1
        phases.append(("ORBITING", "E", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2027
        dateComponents.month = 11
        phases.append(("CLOSEOUT", "F", Calendar.current.date(from: dateComponents)!))
        
        let date = Date() // Current date
        // Remove all phases that already passed
        for i in 0 ... phases.count-1 {
            if phases[i].2 < date {
                phases.remove(at: i)
            }
        }
    }
    
    // Initialize countdown clock
    func initTimer() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel)
    }
    
    // Updates all the timer labels
    func updateTimerLabel(t: Timer) {
        var diff = Int(phases[currentDateIndex].2.timeIntervalSince(Date.init()))
        
        let days = diff / 86400 // 86400 = 60 * 60 * 24
        diff -= days * 86400
        let hours = diff / 3600 // 3600 = 60 * 60
        diff -= hours * 3600
        let minutes = diff / 60
        diff -= minutes * 60
        let seconds = diff
        
        daysLabel.text = "\(days)"
        timerLabel.text = String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
        
        if (dropdownShowing == 1) { // If dropdown is showing, then loop through all the dates and update the labels
            dateViews.forEach { (dateView) in
                diff = Int(phases[dateView.id].2.timeIntervalSince(Date.init()))
                let years = diff / 31536000 // 31536000 = 60 * 60 * 24 * 365
                diff -= years * 31536000
                let days = diff / 86400 // 86400 = 60 * 60 * 24
                diff -= days * 86400
                let hours = diff / 3600 // 3600 = 60 * 60
                
                if (years > 0) {
                    dateView.yearLabel?.text = "\(years)"
                    dateView.dayLabel?.text = "\(days)"
                    dateView.hourLabel?.text = "\(hours)"
                } else {
                    diff -= hours * 3600
                    let minutes = diff / 60
                    diff -= minutes * 60
                    let seconds = diff
                    
                    dateView.dayLabel?.text = "\(days)"
                    dateView.hourLabel?.text = String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
                }
            }
        }
    }
}

