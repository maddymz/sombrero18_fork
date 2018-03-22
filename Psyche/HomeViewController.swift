//
//  HomeViewController.swift
//  Psyche
//
//  Created by Rivinis on 12/14/17.
//  Copyright © 2017 ASU. All rights reserved.
//

// imports
import UIKit
import SpriteKit
import Foundation
import AVFoundation

// custom class used for the dates on the drop down blur
class DateView : UIView {
    var id = 0
    var yearLabel: UILabel?
    var dayLabel: UILabel?
    var hourLabel: UILabel? // If years == 0, then this will be the timer label
}

// class
class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    // vars
    var contentWidth: CGFloat = 0.0
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    var passedVar = ""
    
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
    let yearLabelX = 82
    let yearMLabelX = 82
    let dayLabelX = 188
    let dayMLabelX = 188
    let hourLabelX = 314
    let hourMLabelX = 314
    let timeMLabelXConst = 1
    
    // Y positions
    let dateLabelYConst = -20
    let timeLabelYConst = -10
    let timeMLabelYConst = 16
    let separation = 90 // distance between the different dates
    
    // outlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timeBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var blurHeight: NSLayoutConstraint!
    @IBOutlet weak var blurY: NSLayoutConstraint!
    @IBOutlet weak var blurTitle: UILabel!
    @IBOutlet weak var blurText: UITextView!
    @IBOutlet weak var blurTextHeight: NSLayoutConstraint!
    @IBOutlet weak var blurTextY: NSLayoutConstraint!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    
    // actions
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: self.view).y
            
            if translation < 0 {
                if blurY.constant > 8 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant += translation / 10
                        self.view.layoutIfNeeded()
                        
                        self.blurTextY.constant -= translation / 20
                        self.blurTextHeight.constant -= translation / 10
                    })
                }
            } else {
                if blurY.constant < 390 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant += translation / 10
                        self.view.layoutIfNeeded()
                        
                        self.blurTextY.constant -= translation / 20
                        self.blurTextHeight.constant -= translation / 10
                    })
                }
            }
        } else if sender.state == .ended {
            if blurY.constant < 265 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.blurY.constant = 8
                    self.view.layoutIfNeeded()
                    self.arrowImage.image = UIImage(named: "ArrowF")
                    self.arrowImage.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
                    self.blurTextY.constant = 18
                    self.blurTextHeight.constant = 420
                    self.blurText.isScrollEnabled = true
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.blurY.constant = 390
                    self.view.layoutIfNeeded()
                    self.arrowImage.image = UIImage(named: "Arrow")
                    self.arrowImage.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
                    self.blurTextY.constant = -170
                    self.blurTextHeight.constant = 40
                    self.blurText.isScrollEnabled = false
                })
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
                self.blurText.flashScrollIndicators()
            }
        }
    }
    
    // methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTimer() // initialize countdown timer
        
        //add and hide menu
        Menu.layer.zPosition = 2;
        view.addSubview(Menu)
        Menu.frame = CGRect(x:-300, y:0, width: 265, height:self.view.frame.height)
        
        //adaptability constraints
        gradientView.frame.size.width = view.frame.width
        scrollView.frame.size.width = view.frame.width
        
        // gradient view
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor(red: 250/255.5, green: 160/255.5, blue: 0/255.5, alpha: 1.0).cgColor, UIColor(red: 244/255.5, green: 124/255.5, blue: 51/255.5, alpha: 1.0).cgColor, UIColor(red: 239/255.5, green: 89/255.5, blue: 102/255.5, alpha: 1.0).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        // shadows
        gradientView.layer.shadowColor = UIColor.orange.cgColor
        gradientView.layer.shadowOpacity = 1
        gradientView.layer.shadowOffset = CGSize(width: 0, height: 0)
        blurView.layer.shadowColor = UIColor.white.cgColor
        blurView.layer.shadowOpacity = 1
        blurView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // background gif
        gifView.loadGif(name: "output")
        
        // animations
        gifView.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        timeBar.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        blurView.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        arrowImage.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        
        // blur view
        blurY.constant = 390
        blurHeight.constant = 554
        blurTextHeight.constant = 40
        blurTextY.constant = -170
        blurText.textContainer.lineFragmentPadding = 0
        blurText.textContainerInset = .zero
        blurText.text = blurText.fillTextZero()
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
            self.blurText.flashScrollIndicators()
        }
        
        // scroll view
        scrollView.delegate = self
        for image in 0...3 {
            let imageToDisplay = UIImage(named: "\(image)")
            let imageView = UIImageView(image: imageToDisplay)
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
            contentWidth += view.frame.width
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate - 187.5, y: (view.frame.height / 2) - 335, width: 375, height: 554)
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: 1.0)
        
        timeBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.timeBarTap))) // adds tap event handler for timeBar
        
        // initialize blur variables
        timeBlurYPos = Int(stackView.frame.height)
        timeBlurHeight = Int(view.bounds.height) - timeBlurYPos
        timeBlurWidth = Int(view.bounds.width)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = CGRect(x: 0, y: timeBlurYPos - timeBlurHeight, width: timeBlurWidth, height: timeBlurHeight)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dropdownView.frame = CGRect(x: 0, y: timeBlurYPos - timeBlurHeight, width: timeBlurWidth, height: timeBlurHeight)
        
        //stackView.layer.zPosition = 1 // makes stackView above other UI elements
        
        addDates() // add dates to dates array
    }
    
    // functions
    
    // handles tap on timeBar
    @objc func timeBarTap(sender:UITapGestureRecognizer) {
        if (dropdownShowing == 0) { //dropdown is not showing, show
            view.addSubview(blurEffectView)
            view.addSubview(dropdownView)
            
            addCountdownLabels()
            
            stackView.layer.zPosition = 1
            
            
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
                self.stackView.layer.zPosition = 0
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
                //updateTimerLabel(t: countdownTimer!)
                currentDateIndex = dateView.id
                countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel)
                countdownTimer?.fire()
                
                timeBarTap(sender: sender)
                return
            }
        }
    }
    
    @objc func playerItemReachEnd(notification: NSNotification) {
        Player.seek(to: kCMTimeZero)
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
                dateView.frame = CGRect(x: 0, y: i * separation, width: Int(view.bounds.width), height: separation)
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
                    
                    yearLabel.font = UIFont(name: "Roboto Mono", size: 36)
                    dayLabel.font = UIFont(name: "Roboto Mono", size: 36)
                    hourLabel.font = UIFont(name: "Roboto Mono", size: 36)
                    yearMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    dayMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    hourMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    //yearLabel.font = yearLabel.font.withSize(36)
                    //dayLabel.font = dayLabel.font.withSize(36)
                    //hourLabel.font = hourLabel.font.withSize(36)
                    //yearMLabel.font = yearLabel.font.withSize(10)
                    //dayMLabel.font = dayLabel.font.withSize(10)
                    //hourMLabel.font = hourLabel.font.withSize(10)
                    
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
                    
                    dayLabel.text = result.1
                    timeLabel.text = result.2
                    timeLabel.textColor = UIColor.gray
                    dayLabel.textColor = UIColor.gray
                    
                    dayMLabel.text = "DAYS"
                    timeMLabel.text = "HOURS : MINUTES : SECONDS"
                    timeMLabel.textColor = UIColor.gray
                    dayMLabel.textColor = UIColor.gray
                    
                    timeLabel.font = UIFont(name: "Roboto Mono", size: 36)
                    dayLabel.font = UIFont(name: "Roboto Mono", size: 36)
                    timeMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    dayMLabel.font = UIFont(name: "Roboto Mono", size: 10)
                    //timeLabel.font = timeLabel.font.withSize(36)
                    //dayLabel.font = dayLabel.font.withSize(36)
                    //timeMLabel.font = timeMLabel.font.withSize(10)
                    //dayMLabel.font = dayLabel.font.withSize(10)
                    
                    dateView.addSubview(timeLabel)
                    dateView.addSubview(timeMLabel)
                    dateView.addSubview(dayLabel)
                    dateView.addSubview(dayMLabel)
                    
                    dateView.dayLabel = dayLabel
                    dateView.hourLabel = timeLabel
                }
                
                dateLabel.text = dateLabels[i]
                dateLabel.textColor = UIColor.black
                dateLabel.font = dateLabel.font.withSize(10)
                dateView.addSubview(dateLabel)
                
                if (i < max) {
                    let line = UIView()
                    line.frame = CGRect(x: 16, y: timeMLabelYConst + 75, width: Int(view.bounds.width - 32), height: 1)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(view.frame.width))
        if (pageControl.currentPage == 0) {
            blurTitle.text = "Psyche in Depth"
            blurText.text = blurText.fillTextZero()
        } else if (pageControl.currentPage == 1) {
            blurTitle.text = "ASU to Lead Psyche Mission"
            blurText.text = blurText.fillTextOne()
        } else if (pageControl.currentPage == 2) {
            blurTitle.text = "Project Management Basics"
            blurText.text = blurText.fillTextTwo()
        } else if (pageControl.currentPage == 3) {
            blurTitle.text = "The Artists Helping NASA"
            blurText.text = blurText.fillTextThree()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //menu functions (include in all pages with hamburger)
    @IBAction func menuClicked(_ sender: Any) {
        self.menuBlur.layer.zPosition = 1
        self.menuBlur.alpha = 0
        self.menuBlur.layer.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.menuBlur.alpha = 1.0
            self.tabBarController?.tabBar.alpha = 0
            self.Menu.transform = CGAffineTransform(translationX: 300, y: 0)
        }) { (success) in
            self.tabBarController?.tabBar.isHidden = true
        }
        
    }
    
    @IBAction func closeMenu(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.alpha = 1.0
            self.menuBlur.alpha = 0
            self.Menu.transform = CGAffineTransform(translationX: -300, y: 0)
        }) { (success) in
            self.menuBlur.layer.isHidden = true
        }
    }
    
    @IBAction func notification(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func contactUs(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func partners(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func getInvolved(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func blog(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func termsConditions(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://psyche.asu.edu")!, options: [:], completionHandler: { (status) in
            
        })
    }
    
    @IBAction func openYoutube(_ sender: Any) {
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
    
    @IBAction func openTwitter(_ sender: Any) {
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
    
    @IBAction func openFB(_ sender: Any) {
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
    
    @IBAction func openInsta(_ sender: Any) {
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

