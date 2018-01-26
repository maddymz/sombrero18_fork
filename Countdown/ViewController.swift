//
//  ViewController.swift
//  Countdown
//
//  Created by Joshua on 11/8/17.
//  Copyright © 2017 NASA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var yearsMarkerLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var daysMarkerLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerMarkerLabel: UILabel!
    
    var clockTimer = Timer()

    var dateButtons = [UIButton]()
    
    var selectedButton = UIButton()
    
    var diff = 0 // Keeps track of total seconds for the countdown clock
    
    // Dates that can be selected to countdown to
    var launchDate = Date()
    var date2 = Date()
    var date3 = Date()
    var date4 = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDates()
        createDropDown()
        initTimer()
    }

    @objc func handleSelectDropDownButtons(_ sender: UIButton) {
        let title = sender.currentTitle!
        
        if (title == "Mission Review") {
            diff = Int(date2.timeIntervalSince(Date.init())) // Total minutes
        } else if (title == "Mission Launch") {
            diff = Int(launchDate.timeIntervalSince(Date.init())) // Total minutes
        } else if (title == "Arrival") {
            diff = Int(date3.timeIntervalSince(Date.init())) // Total minutes
        } else if (title == "Exploration") {
            diff = Int(date4.timeIntervalSince(Date.init())) // Total minutes
        }
        selectedButton.setTitle(title, for: .normal)
        
        switchTimerLabel()
        
        dateButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
            })
        }
    }
    
    @objc func handleSelectTopButton(_ sender: UIButton) {
        dateButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
            })
        }
    }
    
    // Creates a drop down menu of different dates
    func createDropDown() {
        var index = 0
        
        let titles = ["Mission Review", "Mission Review", "Mission Launch", "Arrival", "Exploration"]
        for title in titles {
            createButton(index: index, title: title)
            index += 1
        }
    }
    
    // Creates a button used in the drop dow' menu
    func createButton(index: Int, title: String) {
        let button = UIButton(type: UIButtonType.system) as UIButton
        button.frame = CGRect(x: 2, y: 84 + 41 * index, width: 124, height: 41)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        if (index == 0) {
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(handleSelectTopButton(_:)), for: .touchUpInside)
            selectedButton = button
        } else {
            button.isHidden = true
            button.backgroundColor = UIColor.darkGray
            button.setTitleColor(.white, for: .normal)
            dateButtons.append(button)
            button.addTarget(self, action: #selector(handleSelectDropDownButtons(_:)), for: .touchUpInside)
        }
        
        self.view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTimer() {
        clockTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel) // Initializes the timer that updates the labels
        
        diff = Int(launchDate.timeIntervalSince(Date.init())) // Total seconds
        switchTimerLabel()
        
        selectedButton.setTitle("Mission Launch", for: .normal)
    }
    
    // Sets position of labels based on if years > 0 for the selected date
    public func switchTimerLabel() {
        var tempDiff = diff
        let years = tempDiff / 31536000 // 31536000 = 60 * 60 * 24 * 365
        tempDiff -= years * 31536000
        
        if (years > 0) {
            yearsLabel.isHidden = false
            yearsMarkerLabel.isHidden = false
            daysLabel.frame = CGRect(origin: CGPoint(x: 177, y: 60), size: CGSize(width: 58, height: 54))
            daysMarkerLabel.frame = CGRect(origin: CGPoint(x: 194, y: 111), size: CGSize(width: 43, height: 21))
            timerLabel.frame = CGRect(origin: CGPoint(x: 245, y: 60), size: CGSize(width: 130, height: 54))
            timerMarkerLabel.frame = CGRect(origin: CGPoint(x: 252, y: 111), size: CGSize(width: 144, height: 21))
            yearsLabel.text = "\(years)"
        } else {
            yearsLabel.isHidden = true
            yearsMarkerLabel.isHidden = true
            daysLabel.frame = CGRect(origin: CGPoint(x: 135, y: 60), size: CGSize(width: 58, height: 54))
            daysMarkerLabel.frame = CGRect(origin: CGPoint(x: 149, y: 111), size: CGSize(width: 43, height: 21))
            timerLabel.frame = CGRect(origin: CGPoint(x: 213, y: 60), size: CGSize(width: 130, height: 54))
            timerMarkerLabel.frame = CGRect(origin: CGPoint(x: 222, y: 111), size: CGSize(width: 144, height: 21))
        }
        
        let days = tempDiff / 86400 // 86400 = 60 * 60 * 24
        tempDiff -= days * 86400
        let hours = tempDiff / 3600 // 3600 = 60 * 60
        tempDiff -= hours * 3600
        let minutes = tempDiff / 60
        tempDiff -= minutes * 60
        let seconds = tempDiff
        
        daysLabel.text = "\(days)"
        timerLabel.text = String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
    
    // Updates yearsLabel, daysLabel, and timerLabel with the time until launch date
    func updateTimerLabel(t: Timer) {
        diff -= 1
        var tempDiff = diff
        
        let years = tempDiff / 31536000 // 31536000 = 60 * 60 * 24 * 365
        tempDiff -= years * 31536000
        let days = tempDiff / 86400 // 86400 = 60 * 60 * 24
        tempDiff -= days * 86400
        let hours = tempDiff / 3600 // 3600 = 60 * 60
        tempDiff -= hours * 3600
        let minutes = tempDiff / 60
        tempDiff -= minutes * 60
        let seconds = tempDiff
        
        yearsLabel.text = "\(years)"
        daysLabel.text = "\(days)"
        timerLabel.text = String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }

    // Set dates
    func setDates() {
        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 7
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "CST")
        dateComponents.hour = 9
        dateComponents.minute = 0
        launchDate = Calendar.current.date(from: dateComponents)!
        
        dateComponents.year = 2018
        dateComponents.month = 9
        dateComponents.day = 23
        dateComponents.hour = 5
        dateComponents.minute = 45
        date2 = Calendar.current.date(from: dateComponents)!
        
        dateComponents.year = 2020
        dateComponents.month = 12
        dateComponents.day = 1
        dateComponents.hour = 9
        dateComponents.minute = 10
        date3 = Calendar.current.date(from: dateComponents)!
        
        dateComponents.year = 2026
        dateComponents.month = 3
        dateComponents.day = 11
        dateComponents.hour = 14
        dateComponents.minute = 30
        date4 = Calendar.current.date(from: dateComponents)!
    }
}
