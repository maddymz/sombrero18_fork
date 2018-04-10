//
//  CountdownClockHome.swift
//  Psyche
//
//  Created by Joshua on 4/9/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import UIKit
import Foundation

// custom class used for the dates on the drop down blur
class DateView : UIView {
    var id = 0
    var yearLabel: UILabel?
    var dayLabel: UILabel?
    var hourLabel: UILabel? // If years == 0, then this will be the timer label
}

class CountdownClockHome : UIView {
    var hvc : HomeViewController!
    
    var daysLabel = UILabel()
    var daysMLabel = UILabel()
    var timerLabel = UILabel()
    var timerMLabel = UILabel()
    var secondsMLabel = UILabel()
    var psycheLogo = UIImageView()
    
    var dates = [Date]() // array of dates for countdown clock
    var dateLabels = [String]() // array of names for dates
    var currentDateIndex = 0 // index of date being displayed
    var dateViews = [DateView]()
    
    weak var countdownTimer: Timer? // timer that ticks every second and updates the label
    
    // variables for the drop down blur
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
    let blurEffectView = UIVisualEffectView()
    var timeBlurYPos = 0 // Y position of blur drop down
    var timeBlurHeight = 0
    var timeBlurWidth = 0
    let dropdownView = UIView() // this view rests on top of the blurEffectView
    
    var dropdownShowing = 0 // 0 means dropdown not showing, 1 means dropdown is showing
    
    // alignment constants for drop down
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
    let separation = 90 // distance between the different dates
    
    init(frame: CGRect, parent: HomeViewController) {
        super.init(frame: frame)
        
        self.hvc = parent
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTap))) // adds tap event handler
        
        // initialize imageview and labels
        psycheLogo.image = UIImage(named: "Psyche_Icon_30px30px")
        psycheLogo.frame = CGRect(x: 15, y: 10, width: 40, height: 40)
        
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
        
        self.addSubview(psycheLogo)
        self.addSubview(daysLabel)
        self.addSubview(daysMLabel)
        self.addSubview(timerLabel)
        self.addSubview(timerMLabel)
        self.addSubview(secondsMLabel)
        
        // initialize blur variables
        timeBlurYPos = Int(hvc.stackView.frame.height)
        timeBlurHeight = Int(hvc.view.bounds.height) - timeBlurYPos
        timeBlurWidth = Int(hvc.view.bounds.width)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = CGRect(x: 0, y: timeBlurYPos - timeBlurHeight, width: timeBlurWidth, height: timeBlurHeight)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dropdownView.frame = CGRect(x: 0, y: timeBlurYPos - timeBlurHeight, width: timeBlurWidth, height: timeBlurHeight)
        
        addDates() // add dates to dates array
        
        initTimer()
        countdownTimer?.fire() // trigger timer right away, otherwise there is a 1 second delay
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func viewTap(sender: UITapGestureRecognizer) {
        if (dropdownShowing == 0) { //dropdown is not showing, show
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
        } else { // dropdown is showing, unshow
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
    
    // handles user tapping a different countdown date
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
    
    // adds labels to blur effect view
    func addCountdownLabels() {
        var i = 0 // counter for number of views added to the blur
        var j = 0 // counter to loop through dates
        
        let max = dates.count - 2
        
        dateViews.forEach { (dateView) in
            dateView.removeFromSuperview()
        }
        dateViews = [DateView]() // clear the array
        
        dates.forEach { (date) in
            if (j != currentDateIndex) {
                let result = dateToString(date: date)
                
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
                
                dateLabel.text = dateLabels[i]
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
                dateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dateTap))) // adds tap event handler for timeBar
                
                dropdownView.addSubview(dateView)
                dateView.id = j
                dateViews.append(dateView)
                
                i += 1
            }
            j += 1
        }
    }
    
    // formats a date to a string
    func dateToString(date: Date) -> (String, String, String) {
        var tempDiff = Int(date.timeIntervalSince(Date.init())) // number of seconds until date
        
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
    
    // adds countdown dates to dates array
    func addDates() {
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = 7
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "CST")
        dateComponents.hour = 9
        dateComponents.minute = 0
        dates.append(Calendar.current.date(from: dateComponents)!)
        dateLabels.append("ARRIVAL")
        
        dateComponents.year = 2022
        dateComponents.month = 9
        dateComponents.day = 23
        dateComponents.hour = 5
        dateComponents.minute = 45
        dates.append(Calendar.current.date(from: dateComponents)!)
        dateLabels.append("EXPLORE")
        
        dateComponents.year = 2026
        dateComponents.month = 12
        dateComponents.day = 1
        dateComponents.hour = 9
        dateComponents.minute = 10
        dates.append(Calendar.current.date(from: dateComponents)!)
        dateLabels.append("REVIEW")
        
        dateComponents.year = 2028
        dateComponents.month = 3
        dateComponents.day = 11
        dateComponents.hour = 14
        dateComponents.minute = 30
        dates.append(Calendar.current.date(from: dateComponents)!)
        dateLabels.append("DEPART")
    }
    
    // countdown clock
    func initTimer() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel)
    }
    
    // updates all the timer labels
    func updateTimerLabel(t: Timer) {
        var diff = Int(dates[currentDateIndex].timeIntervalSince(Date.init()))
        
        let days = diff / 86400 // 86400 = 60 * 60 * 24
        diff -= days * 86400
        let hours = diff / 3600 // 3600 = 60 * 60
        diff -= hours * 3600
        let minutes = diff / 60
        diff -= minutes * 60
        let seconds = diff
        
        daysLabel.text = "\(days)"
        timerLabel.text = String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
        
        if (dropdownShowing == 1) { // if dropdown is showing, then loop through all the dates and update the labels
            dateViews.forEach { (dateView) in
                diff = Int(dates[dateView.id].timeIntervalSince(Date.init()))
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