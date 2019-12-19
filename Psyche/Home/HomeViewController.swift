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
    
    @IBOutlet weak var topSwipeLabel: UILabel!
    @IBOutlet weak var topArrow: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var blurTextX: NSLayoutConstraint!
    @IBOutlet weak var blurTextWidth: NSLayoutConstraint!
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    @IBOutlet weak var nasaLogo: UIButton!
    
    @IBOutlet weak var nasaTitle: UILabel!
    @IBOutlet weak var menuhamburger: UIButton!
    struct homepageStruct: Decodable {
        let asteroid, spacecraft, science, mission: String
    }
    
    var homeData = [homepageStruct]()
    // actions
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        //to handle the layout for different target screens
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
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
                        self.topArrow.isHidden = false
                        self.topSwipeLabel.isHidden = false
                        self.arrowImage.isHidden = true
                        self.swipeLabel.isHidden = true
                        self.topArrow.image = UIImage(named: "Arrow")
                        self.blurTextY.constant = 18
                        self.blurTextHeight.constant = 420
                        self.blurText.isScrollEnabled = true
                        self.pageControl.isHidden = true
                        self.topSwipeLabel.text = "Swipe"

                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant = 390
                        self.view.layoutIfNeeded()
                        self.arrowImage.isHidden = false
                        self.swipeLabel.isHidden = false
                        self.topArrow.isHidden = true
                        self.topSwipeLabel.isHidden = true
                        self.arrowImage.image = UIImage(named: "ArrowF")
                        self.blurTextY.constant = -170
                        self.blurTextHeight.constant = 40
                        self.blurText.isScrollEnabled = false
                        self.pageControl.isHidden = false
                        self.swipeLabel.text = "Swipe"
                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
                    self.blurText.flashScrollIndicators()
                }
            }
        } else if UIDevice.current.screenType == .iPhone_XR {
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
                        self.topArrow.isHidden = false
                        self.topSwipeLabel.isHidden = false
                        self.arrowImage.isHidden = true
                        self.swipeLabel.isHidden = true
                        self.arrowImage.isHidden = true
                        self.swipeLabel.isHidden = true
                        self.topArrow.image = UIImage(named: "Arrow")
                        self.blurTextY.constant = 0
                        self.blurTextHeight.constant = 600
                        self.blurText.isScrollEnabled = true
                        self.pageControl.isHidden = true
                        self.topSwipeLabel.text = "Swipe"

                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant = 500
                        self.view.layoutIfNeeded()
                        self.arrowImage.isHidden = false
                        self.swipeLabel.isHidden = false
                        self.topArrow.isHidden = true
                        self.topSwipeLabel.isHidden = true
                        self.arrowImage.image = UIImage(named: "ArrowF")
                        self.blurTextY.constant = -260
                        self.blurTextHeight.constant = 80
                        self.blurText.isScrollEnabled = false
                        self.pageControl.isHidden = false
                        self.swipeLabel.text = "Swipe"

                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
                    self.blurText.flashScrollIndicators()
                }
            }
        } else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
           
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
                        self.topArrow.isHidden = false
                        self.topSwipeLabel.isHidden = false
                        self.arrowImage.isHidden = true
                        self.swipeLabel.isHidden = true
                        self.topArrow.image = UIImage(named: "Arrow")
                        self.blurTextY.constant = 0
                        self.blurTextHeight.constant = 450
                        self.blurText.isScrollEnabled = true
                        self.pageControl.isHidden = true
                        self.topSwipeLabel.text = "Swipe"

                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant = 430
                        self.view.layoutIfNeeded()
                        self.arrowImage.isHidden = false
                        self.swipeLabel.isHidden = false
                        self.topArrow.isHidden = true
                        self.topSwipeLabel.isHidden = true
                        self.arrowImage.image = UIImage(named: "ArrowF")
                        self.blurTextY.constant = -200
                        self.blurTextHeight.constant = 60
                        self.blurText.isScrollEnabled = false
                        self.pageControl.isHidden = false
                        self.swipeLabel.text = "Swipe"

                        
                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
                    self.blurText.flashScrollIndicators()
                }
            }
        }else if UIDevice.current.screenType == .iPhones_X_XS{
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
                        self.topArrow.isHidden = false
                        self.topSwipeLabel.isHidden = false
                        self.arrowImage.isHidden = true
                        self.swipeLabel.isHidden = true
                        self.topArrow.image = UIImage(named: "Arrow")
                        self.blurTextY.constant = 0
                        self.blurTextHeight.constant = 500
                        self.blurText.isScrollEnabled = true
                        self.pageControl.isHidden = true
                        self.topSwipeLabel.text = "Swipe"


                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant = 460
                        self.view.layoutIfNeeded()
                        self.arrowImage.isHidden = false
                        self.swipeLabel.isHidden = false
                        self.topArrow.isHidden = true
                        self.topSwipeLabel.isHidden = true
                        self.arrowImage.image = UIImage(named: "ArrowF")
                        self.blurTextY.constant = -230
                        self.blurTextHeight.constant = 60
                        self.blurText.isScrollEnabled = false
                        self.pageControl.isHidden = false
                        self.swipeLabel.text = "Swipe"

                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
                    self.blurText.flashScrollIndicators()
                }
            }
        }else if UIDevice.current.screenType == .iPhone_XSMax{
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
                        self.topArrow.isHidden = false
                        self.topSwipeLabel.isHidden = false
                        self.arrowImage.isHidden = true
                        self.swipeLabel.isHidden = true
                        self.topArrow.image = UIImage(named: "Arrow")
                        self.blurTextY.constant = 0
                        self.blurTextHeight.constant = 600
                        self.blurText.isScrollEnabled = true
                        self.pageControl.isHidden = true
                        self.topSwipeLabel.text = "Swipe"


                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant = 500
                        self.view.layoutIfNeeded()
                        self.arrowImage.isHidden = false
                        self.swipeLabel.isHidden = false
                        self.topArrow.isHidden = true
                        self.topSwipeLabel.isHidden = true
                        self.arrowImage.image = UIImage(named: "ArrowF")
                        self.blurTextY.constant = -260
                        self.blurTextHeight.constant = 80
                        self.blurText.isScrollEnabled = false
                        self.pageControl.isHidden = false
                        self.swipeLabel.text = "Swipe"

                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
                    self.blurText.flashScrollIndicators()
                }
            }
        } else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE{
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
                    if blurY.constant < 265 {
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
                        self.topArrow.isHidden = false
                        self.topSwipeLabel.isHidden = false
                        self.arrowImage.isHidden = true
                        self.swipeLabel.isHidden = true
                        self.topArrow.image = UIImage(named: "Arrow")
                        self.blurTextY.constant = 0
                        self.blurTextHeight.constant = 290
                        self.blurText.isScrollEnabled = true
                        self.pageControl.isHidden = true
                        self.topSwipeLabel.text = "Swipe"
                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.blurY.constant = 305
                        self.view.layoutIfNeeded()
                        self.arrowImage.isHidden = false
                        self.swipeLabel.isHidden = false
                        self.topArrow.isHidden = true
                        self.topSwipeLabel.isHidden = true
                        self.arrowImage.image = UIImage(named: "ArrowF")
                        self.blurTextY.constant = -125
                        self.blurTextHeight.constant = 30
                        self.blurText.isScrollEnabled = false
                        self.pageControl.isHidden = false
                        self.swipeLabel.text = "Swipe"
                        


                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
                    self.blurText.flashScrollIndicators()
                }
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
//        gifView.loadGif(name: "ONe")
        
        // animations
        timeBar.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        //blurView.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        self.arrowImage.image = UIImage(named: "ArrowF")
        self.topArrow.isHidden = true
        self.topSwipeLabel.isHidden = true
//        self.arrowImage.fadeIn(duration: 1, delay: 0.5, completion: {(finished: Bool) -> Void in})
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.arrowBlink), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.swipeLabelblink), userInfo: nil, repeats: true)
        self.swipeLabel.text = "Swipe"
        self.swipeLabel.textColor = UIColor.gray
        self.topSwipeLabel.textColor = UIColor.gray
        

        let anchor = view.layoutMarginsGuide
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            blurY.constant = 390
            blurHeight.constant = 554
            blurTextHeight.constant = 40
            blurTextY.constant = -170
            self.swipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.topSwipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.topSwipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 157).isActive = true
            self.topSwipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 65).isActive = true
            self.swipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 157).isActive = true
            self.swipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 581).isActive = true
        } else if UIDevice.current.screenType == .iPhone_XR {
            blurY.constant = 500
            blurHeight.constant = 780
            blurTextHeight.constant = 80
            blurTextY.constant = -260
            self.swipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.arrowImage.translatesAutoresizingMaskIntoConstraints = false
            self.topSwipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.topArrow.translatesAutoresizingMaskIntoConstraints = false
            nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.translatesAutoresizingMaskIntoConstraints = false
            menuhamburger.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
            nasaTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 120).isActive = true
            menuhamburger.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
            menuhamburger.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 27).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
            self.arrowImage.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 170).isActive = true
            self.arrowImage.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 720).isActive = true
            self.topArrow.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 170).isActive = true
            self.topArrow.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 50).isActive = true
            self.topSwipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 171).isActive = true
            self.topSwipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 45).isActive = true
            self.swipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 171).isActive = true
            self.swipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 745).isActive = true
        } else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
            blurY.constant = 430
            blurHeight.constant = 630
            blurTextHeight.constant = 40
            blurTextY.constant = -200
            self.stackView.translatesAutoresizingMaskIntoConstraints = false
            self.swipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.arrowImage.translatesAutoresizingMaskIntoConstraints = false
            self.topSwipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.topArrow.translatesAutoresizingMaskIntoConstraints = false
            nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            nasaLogo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 27).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
            self.arrowImage.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 170).isActive = true
            self.arrowImage.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 620).isActive = true
            self.topArrow.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 170).isActive = true
            self.topArrow.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 65).isActive = true
            self.topSwipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 170).isActive = true
            self.topSwipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 60).isActive = true
            self.swipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 171).isActive = true
            self.swipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 645).isActive = true
//            self.stackView.topAnchor.constraint(equalTo: anchor.topAnchor).isActive = true
//            self.stackView.bottomAnchor.constraint(equalTo: anchor.bottomAnchor, constant: 606).isActive = true
//            self.stackView.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 0).isActive = true
//            self.stackView.trailingAnchor.constraint(equalTo: anchor.trailingAnchor, constant: 0).isActive = true
        }else if UIDevice.current.screenType == .iPhones_X_XS{
            blurY.constant = 460
            blurHeight.constant = 700
            blurTextHeight.constant = 60
            blurTextY.constant = -230
            self.swipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.arrowImage.translatesAutoresizingMaskIntoConstraints = false
            self.topArrow.translatesAutoresizingMaskIntoConstraints = false
            self.topSwipeLabel.translatesAutoresizingMaskIntoConstraints = false
            nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.translatesAutoresizingMaskIntoConstraints = false
            menuhamburger.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
            nasaTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 100).isActive = true
            menuhamburger.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
            menuhamburger.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 27).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
            self.arrowImage.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 150).isActive = true
            self.arrowImage.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 640).isActive = true
            self.swipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 151).isActive = true
            self.swipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 665).isActive = true
            self.topArrow.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 150).isActive = true
            self.topArrow.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 50).isActive = true
            self.topSwipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 151).isActive = true
            self.topSwipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 45).isActive = true
        }else if UIDevice.current.screenType == .iPhone_XSMax{
            blurY.constant = 500
            blurHeight.constant = 780
            blurTextHeight.constant = 80
            blurTextY.constant = -260
            self.arrowImage.translatesAutoresizingMaskIntoConstraints = false
            nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.translatesAutoresizingMaskIntoConstraints = false
            menuhamburger.translatesAutoresizingMaskIntoConstraints = false
            self.swipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.topArrow.translatesAutoresizingMaskIntoConstraints = false
            self.topSwipeLabel.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
            nasaTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 120).isActive = true
            menuhamburger.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
            menuhamburger.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 27).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
            self.arrowImage.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 170).isActive = true
            self.arrowImage.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 720).isActive = true
            self.swipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 171).isActive = true
            self.swipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 745).isActive = true
            self.topArrow.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 170).isActive = true
            self.topArrow.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 50).isActive = true
            self.topSwipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 171).isActive = true
            self.topSwipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 45).isActive = true
        } else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE{
            blurY.constant = 305
            blurHeight.constant = 450
            blurTextHeight.constant = 30
            blurTextY.constant = -125
            blurTextWidth.constant = 255
            blurTextX.constant = 4
            
            
            self.arrowImage.translatesAutoresizingMaskIntoConstraints = false
            self.swipeLabel.translatesAutoresizingMaskIntoConstraints = false
            self.topArrow.translatesAutoresizingMaskIntoConstraints = false
            self.topSwipeLabel.translatesAutoresizingMaskIntoConstraints = false
            nasaLogo.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.translatesAutoresizingMaskIntoConstraints = false
            nasaTitle.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
            nasaTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 70).isActive = true
            nasaLogo.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -100).isActive = true
            nasaLogo.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 22).isActive = true
            nasaLogo.heightAnchor.constraint(equalToConstant: 45).isActive = true
            nasaLogo.widthAnchor.constraint(equalToConstant: 45).isActive = true
            self.arrowImage.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 130).isActive = true
            self.arrowImage.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 460).isActive = true
            self.swipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 131).isActive = true
            self.swipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 485).isActive = true
            self.topArrow.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 130).isActive = true
            self.topArrow.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 65).isActive = true
            self.topSwipeLabel.leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: 131).isActive = true
            self.topSwipeLabel.topAnchor.constraint(equalTo: anchor.topAnchor, constant: 60).isActive = true
   
        }
        blurText.textContainer.lineFragmentPadding = 0
        blurText.textContainerInset = .zero
        blurTitle.text = "Mission"
        blurText.text = homeData[0].mission
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500000)) {
            self.blurText.flashScrollIndicators()
        }
        
        // scroll view
        scrollView.delegate = self
       
            
            print("screentype", UIDevice.current.screenType)
            if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
                for image in 0...3 {
                    let imageToDisplay = UIImage(named: "\(String(image) + "_375x325")")
                    let imageView = UIImageView(image: imageToDisplay)
                    let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
                    contentWidth += view.frame.width
                    scrollView.addSubview(imageView)
                    imageView.frame = CGRect(x: xCoordinate - 187.5, y: (view.frame.height / 2) - 335, width: view.frame.width, height: 325)
                }
            } else if UIDevice.current.screenType == .iPhone_XR {
                for image in 0...3 {
                    let imageToDisplay = UIImage(named: "\(image)" + "_414x450")
                    let imageView = UIImageView(image: imageToDisplay)
                    let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
                    contentWidth += view.frame.width
                    scrollView.addSubview(imageView)
                    imageView.frame = CGRect(x: xCoordinate - 207.2, y: (view.frame.height / 2) - 450, width: view.frame.width, height: 450)
                }
            } else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
                for image in 0...3 {
                    let imageToDisplay = UIImage(named: "\(image)" + "_414x380")
                    let imageView = UIImageView(image: imageToDisplay)
                    let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
                    contentWidth += view.frame.width
                    scrollView.addSubview(imageView)
                    imageView.frame = CGRect(x: xCoordinate - 207, y: (view.frame.height / 2) - 385, width: view.frame.width, height: 380)
                }
            }else if UIDevice.current.screenType == .iPhones_X_XS{
                for image in 0...3 {
                    let imageToDisplay = UIImage(named: "\(image)" + "_375x400")
                    let imageView = UIImageView(image: imageToDisplay)
                    let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
                    contentWidth += view.frame.width
                    scrollView.addSubview(imageView)
                    imageView.frame = CGRect(x: xCoordinate - 187.5, y: (view.frame.height / 2) - 410, width: view.frame.width, height: 400)
                }
            }else if UIDevice.current.screenType == .iPhone_XSMax{
                for image in 0...3 {
                    let imageToDisplay = UIImage(named: "\(image)" + "_414x450")
                    let imageView = UIImageView(image: imageToDisplay)
                    let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
                    contentWidth += view.frame.width
                    scrollView.addSubview(imageView)
                    imageView.frame = CGRect(x: xCoordinate - 207.2, y: (view.frame.height / 2) - 450, width: view.frame.width, height: 450)
                }
            } else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE{
                for image in 0...3 {
                    let imageToDisplay = UIImage(named: "\(image)" + "_320x250")
                    let imageView = UIImageView(image: imageToDisplay)
                    let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
                    contentWidth += view.frame.width
                    scrollView.addSubview(imageView)
                    imageView.frame = CGRect(x: xCoordinate - 160, y: (view.frame.height / 2) - 290, width: view.frame.width, height: 250)
                }
            }
           
        
        scrollView.contentSize = CGSize(width: contentWidth, height: 1.0)
        
        // Add countdown clock component
        addCountdownClockHome()
        
         //tap recognizer to close menu
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        self.menuBlur.addGestureRecognizer(tapOut)
        
    }
    
    
    // functions
    
    @objc func arrowBlink(){
        UIView.animate(withDuration: 0.7) {
            self.arrowImage.alpha = self.arrowImage.alpha == 1.0 ? 0.0 : 1.0
            self.topArrow.alpha = self.topArrow.alpha == 1.0 ? 0.0 : 1.0
        }
    }
    
    @objc func swipeLabelblink(){
        UIView.animate(withDuration: 0.7) {
            self.swipeLabel.alpha = self.swipeLabel.alpha == 1.0 ? 0.0 : 1.0
            self.topSwipeLabel.alpha = self.topSwipeLabel.alpha == 1.0 ? 0.0 : 1.0
        }
    }
 
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
            blurTitle.text = "Mission"
            blurText.text = homeData[0].mission
        } else if (pageControl.currentPage == 1) {
            blurTitle.text = "The Asteroid"
            blurText.text = homeData[0].asteroid
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
    
    @IBAction func openNASA(_ sender: Any) {
        menuHelper.openNASA(vc: self)
    }
    
    @IBAction func openTeam(_ sender: Any) {
        menuHelper.openTeam(vc: self)
    }
    
}
