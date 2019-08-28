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
    
    var phaseImg = UIImageView()
    var phaseMLabel = UILabel()
    var daysLabel = UILabel()
    var daysMLabel = UILabel()
    var timerLabel = UILabel()
    var timerMLabel = UILabel()
    var secondsMLabel = UILabel()
    var launchYearLabel = UILabel()
    var launchYearVal = UILabel()
    var launchInfoLabel = UILabel()
    
    var phases: [(label: String, phase: String, date: Date)] = [] // Array of tuples
    var removedPhases : [String] = [] // Array contains removed phases
    var dateLabels = [String]() // Array of names for dates
    var currentDateIndex = 0 // Index of date being displayed
    var index = -1
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
    var yearLabelX = 101
    var yearMLabelX = 101
    var dayLabelX = 199
    var dayMLabelX = 199
    var hourLabelX = 314
    var hourMLabelX = 314
    var secondsMLabelX = 317
    let timeMLabelXConst = 1
    
    // Y positions
    let dateLabelYConst = -20
    let timeLabelYConst = -10
    let timeMLabelYConst = 16
    let separation = 90 // Distance between the different dates
    
    var width = 0
    
    init(frame: CGRect, parent: HomeViewController) {
        super.init(frame: frame)
        
        self.hvc = parent
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTap))) // Adds tap event handler
        
        // Initialize imageview and labels
//        phaseImg.frame = CGRect(x: 15, y: 14, width: 25, height: 25)
        phaseMLabel.frame = CGRect(x: 15, y: 15, width: 40, height: 21)
////        phaseMLabel.text = "PHASE"
        phaseMLabel.text = "LAUNCH"
        
        launchInfoLabel.frame = CGRect(x: 15, y: 25, width: 40, height: 21)
        launchInfoLabel.text = "IN"
        
        launchYearLabel.frame = CGRect(x: 70, y: 41, width: 40, height: 21)
        launchYearLabel.text = "YEARS"
        
        launchYearVal.frame = CGRect(x: 80, y: 9, width: 20, height: 33)
        launchYearVal.text = "2"
        
        //40 + 15 + 164 - 82
        width = Int(hvc.view.bounds.width)
        
        let space = (width - 15 * 2 - 25 - 164 - 82) / 3
        
        yearLabelX = 60 + space * 2 + 10
        yearMLabelX = 100 + space + 10
        dayLabelX = 40 + space * 2 + 82 + space
        dayMLabelX = dayLabelX
        secondsMLabelX = width - 41 - 15
        hourLabelX = width - 41 - 15
        hourMLabelX = hourLabelX
        
        daysLabel.frame = CGRect(x: yearLabelX, y: 9, width: 100, height: 33)
        
        daysMLabel.text = "DAYS"
        
        timerLabel.frame = CGRect(x: dayLabelX, y: 11, width: 164, height: 29)
        
        timerMLabel.frame = CGRect(x: dayMLabelX + 2, y: 41, width: 110, height: 21)
        timerMLabel.text = "HOURS     MINUTES"
        
        secondsMLabel.frame = CGRect(x: secondsMLabelX, y: 41, width: 43, height: 21)
        secondsMLabel.text = "SECONDS"
        
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            daysMLabel.frame = CGRect(x: yearMLabelX + 3, y: 41, width: 50, height: 21)
        } else {
            daysMLabel.frame = CGRect(x: yearMLabelX + 3, y: 41, width: 110, height: 21)

        }
        
        daysLabel.font = UIFont(name: "Roboto Mono", size: 34)
        daysMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        timerLabel.font = UIFont(name: "Roboto Mono", size: 34)
        timerMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        secondsMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        phaseMLabel.font = UIFont(name: "Roboto Mono", size: 10)
        launchYearLabel.font = UIFont(name: "Roboto Mono", size: 10)
        launchYearVal.font = UIFont(name: "Roboto Mono", size: 34)
        launchInfoLabel.font = UIFont(name: "Roboto Mono", size: 10)
        
        daysLabel.textColor = UIColor.white
        daysMLabel.textColor = UIColor.white
        timerLabel.textColor = UIColor.white
        timerMLabel.textColor = UIColor.white
        secondsMLabel.textColor = UIColor.white
        phaseMLabel.textColor = UIColor.white
        launchYearLabel.textColor = UIColor.white
        launchYearVal.textColor = UIColor.white
        launchInfoLabel.textColor = UIColor.white
        
        self.addSubview(phaseImg)
        self.addSubview(phaseMLabel)
        self.addSubview(daysLabel)
        self.addSubview(daysMLabel)
        self.addSubview(timerLabel)
        self.addSubview(timerMLabel)
        self.addSubview(secondsMLabel)
        self.addSubview(launchYearLabel)
        self.addSubview(launchYearVal)
        self.addSubview(launchInfoLabel)
        
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
        let phase = removedPhases[currentDateIndex]
//        phaseImg.image = UIImage(named: "Phase_\(phase)")
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
        scrollView.contentSize = CGSize(width: width, height: separation * phases.count)
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: Int(dropdownView.bounds.height))
        dropdownView.addSubview(scrollView)
        
        phases.forEach { (phase) in
            if (j != index) {
                let result = dateToString(date: phase.2)
                
                let dateView = DateView()
                dateView.frame = CGRect(x: 0, y: i * separation, width: Int(self.bounds.width), height: separation)
               
//                if (result.0 != "") { // years > 0
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

                let dateLabel = UILabel()
                dateLabel.frame = CGRect(x: dateLabelX, y: dateLabelYConst, width: 100, height: 100)
                dateLabel.text = phase.0
                dateLabel.textColor = UIColor.black
                dateLabel.font = dateLabel.font.withSize(10)
                dateView.addSubview(dateLabel)
                
                if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
                    dateLabel.frame = CGRect(x: dateLabelX - 10, y: dateLabelYConst, width: 100, height: 100)
                    dateLabel.font = dateLabel.font.withSize(8)
                }
                
                if (i < max) {
                    let line = UIView()
                    line.frame = CGRect(x: 15, y: timeMLabelYConst + 75, width: width - 30, height: 1)
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
        
        return ("\(years)", "\(days)", "\(hours)")

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
        dateComponents.year = 2017
        dateComponents.month = 1
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "CST")
        dateComponents.hour = 0
        dateComponents.minute = 0
        phases.append(("PHASE B", "B", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2019
        dateComponents.month = 5
        dateComponents.day = 25
        phases.append(("PHASE C", "C", Calendar.current.date(from: dateComponents)!))
        
        
        dateComponents.year = 2021
        dateComponents.month = 1
        dateComponents.day = 22
        phases.append(("PHASE D", "D", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2022
        dateComponents.month = 8
        dateComponents.day = 20
        phases.append(("LAUNCH", "D", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2022
        dateComponents.month = 10
        dateComponents.day = 1
        phases.append(("PHASE E", "E", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2026
        dateComponents.month = 1
        dateComponents.day = 14
        phases.append(("CAPTURE", "E", Calendar.current.date(from: dateComponents)!))
        
//        dateComponents.year = 2027
//        dateComponents.month = 10
//        dateComponents.day = 31
//        phases.append(("MISSION END", "E", Calendar.current.date(from: dateComponents)!))
        
        dateComponents.year = 2027
        dateComponents.month = 11
        dateComponents.day = 1
        phases.append(("PHASE F", "F", Calendar.current.date(from: dateComponents)!))
       
        dateComponents.year = 2028
        dateComponents.month = 8
        dateComponents.day = 1
        phases.append(("CLOSEOUT", "F", Calendar.current.date(from: dateComponents)!))
        
        let date = Date() // Current date
        // Remove all phases that already passed
        for phase in  phases{
            if phase.2 < date {
                removedPhases = [phase.1]
                phases = phases.filter {$0 != phase}
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
//        var diff = Int(phases[currentDateIndex].2.timeIntervalSince(Date.init()))
        var finalDate = DateComponents()
        finalDate.year = 2022
        finalDate.month = 08
        finalDate.day = 20
        var diff = Int((Calendar.current.date(from: finalDate)!).timeIntervalSince(Date.init()))
        print("diff", diff)
        let years = diff/31536000
        print("years",years)
        diff -= years * 31536000
        let days = diff / 86400 // 86400 = 60 * 60 * 24
        print("days", days)
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
                
                    dateView.yearLabel?.text = "\(years)"
                    dateView.dayLabel?.text = "\(days)"
                    dateView.hourLabel?.text = "\(hours)"
            }
        }
    }
}

