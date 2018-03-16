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

// class
class HomeViewController: UIViewController, UIScrollViewDelegate {

// vars
    var launchDate = Date()
    var contentWidth: CGFloat = 0.0
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    var passedVar = ""
    
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
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.blurY.constant = 390
                    self.view.layoutIfNeeded()
                    self.arrowImage.image = UIImage(named: "Arrow")
                    self.arrowImage.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
                    self.blurTextY.constant = -170
                    self.blurTextHeight.constant = 40
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
        setLaunchDate()
        initTimer()
        
        //adaptability constraints
        gradientView.frame.size.width = view.frame.width
        scrollView.frame.size.width = view.frame.width
        //blurView.frame.size.width = view.frame.width;
        
        /*
        let gradientLeyer = CAGradientLayer()
        gradientLeyer.frame = self.view.frame
        gradientLeyer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor(red: 124/255.5, green: 14/255.5, blue: 54/255.5, alpha: 1.0).cgColor]
        gradientLeyer.locations = [0.0, 0.5, 1.0]
        gradientLeyer.startPoint = CGPoint(x:0.0, y: 1.0)
        gradientLeyer.endPoint = CGPoint(x: 1.0, y: 0.0)
        self.timeBar.layer.addSublayer(gradientLeyer)
        */
        /*
         let navBackground = UIImage(named: "topGradient")!
         self.navigationController!.navigationBar.setBackgroundImage(navBackground, for: .default)
        */
        
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
        
// navigation controller
        /*
        let navBackground = UIImage(named: "topGradient")!
        self.navigationController!.navigationBar.setBackgroundImage(navBackground, for: .default)
        */
    }

// functions
    @objc func playerItemReachEnd(notification: NSNotification) {
        Player.seek(to: kCMTimeZero)
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
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimerLabel)
    }
    
    // Updates timerLabel and daysLabel with the time until launch date
    func updateTimerLabel(t: Timer) {
        var diff = Int(launchDate.timeIntervalSince(Date.init()))
        
        //print(diff)
        
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
    
    // Initializes launch date, NASA website said summer of 2022?
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
