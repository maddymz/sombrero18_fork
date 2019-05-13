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
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    struct homepageStruct: Decodable {
        let astroid, spacecraft, science, depth: String
    }
    
    var homeData = [homepageStruct]()
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
                    self.blurY.constant = 17
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
    
        //parse json from homepage.json
        if let homeDataUrl = Bundle.main.url(forResource: "Homepage", withExtension: "json", subdirectory: "/Data"){
            do {
                let homepageData = try Data(contentsOf: homeDataUrl)
                let homepageDecoder = JSONDecoder()
                let homeDecodedData =  try homepageDecoder.decode(homepageStruct.self, from: homepageData)
                homeData = [homeDecodedData]
            }catch let parseError {
                print("Error in parsing json:", parseError)
            }
        }
        
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
        gifView.loadGif(name: "ONe")
        
        // animations
        gifView.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        timeBar.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        //blurView.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        //arrowImage.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        
        // blur view
        blurY.constant = 390
        blurHeight.constant = 554
        blurTextHeight.constant = 40
        blurTextY.constant = -170
        blurText.textContainer.lineFragmentPadding = 0
        blurText.textContainerInset = .zero
        blurTitle.text = "Psyche in depth"
        blurText.text = homeData[0].depth
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
        
        // Add countdown clock component
        addCountdownClockHome()
        
         //tap recognizer to close menu
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        self.menuBlur.addGestureRecognizer(tapOut)
        
    }
    
    
    // functions
    
    // adds countdown clock component
    func addCountdownClockHome() {
        let cch = CountdownClockHome(frame: CGRect(x: 0, y: 64, width: 375, height: 61), parent: self)
        gradientView.addSubview(cch)
    }
    
    @objc func playerItemReachEnd(notification: NSNotification) {
        Player.seek(to: kCMTimeZero)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(view.frame.width))
        if (pageControl.currentPage == 0) {
            blurTitle.text = "Psyche in depth"
            blurText.text = homeData[0].depth
        } else if (pageControl.currentPage == 1) {
            blurTitle.text = "The Astroid"
            blurText.text = homeData[0].astroid
        } else if (pageControl.currentPage == 2) {
            blurTitle.text = "The Spacecraft"
            blurText.text = homeData[0].spacecraft
        } else if (pageControl.currentPage == 3) {
            blurTitle.text = "The Science"
            blurText.text = homeData[0].science
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //menu functions (include in all pages with hamburger)
    @IBAction func menuClicked(_ sender: Any) {
        self.menuBlur.alpha = 0
        self.menuBlur.layer.zPosition = 2
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
    
    @IBAction func events(_ sender: Any) {
        menuHelper.events(vc: self)
    }
    
    @IBAction func contactUs(_ sender: Any) {
        menuHelper.contactUs(vc: self)
    }
    
    @IBAction func science(_ sender: Any) {
        menuHelper.science(vc: self)
    }
    
    @IBAction func getInvolved(_ sender: Any) {
        menuHelper.getInvolved(vc: self)
    }
    
    @IBAction func blog(_ sender: Any) {
        menuHelper.blog(vc: self)
    }
    
    @IBAction func mission(_ sender: Any) {
        menuHelper.mission(vc: self)
    }
    
    @IBAction func openNews(_ sender: Any) {
        menuHelper.news(vc: self)
    }
    
    @IBAction func openYoutube(_ sender: Any) {
        menuHelper.openYoutube(vc: self)
    }
    
    @IBAction func openTwitter(_ sender: Any) {
        menuHelper.openTwitter(vc: self)
    }
    
    @IBAction func openFB(_ sender: Any) {
        menuHelper.openFB(vc: self)
    }
    
    @IBAction func openInsta(_ sender: Any) {
        menuHelper.openInsta(vc: self)
    }
    
    @IBAction func openNASA(_ sender: Any) {
        menuHelper.openNASA(vc: self)
    }
    
}
