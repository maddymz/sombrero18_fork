//
//  TimelineTableViewController.swift
//  PsycheTimeline
//
//  Created by jason on 2/28/18.
//  Copyright © 2018 sombrero. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class TimelineTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WKUIDelegate{
    
    //timeline tableview
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wkWebview: WKWebView!
    
    //Menu
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    // Countdown clock
    let countdownClock = CountdownClockTimeline(frame: CGRect(x: 0, y: 64, width: 325, height: 61))
    
    // MARK: Demo Options
    let debugColors = false // set to true to keep colorful ui element bgs, false to change all bgs to transparent
    let shortenTitles = true // set to true to shorten titles, false to keep original
    let adjustTitleSize = true // set to true to set title font size to 23, false to keep original
    let fixExpandedCellHeights = true // set to true to fix cell heights to predetermined values, false to adjust dynamically (not recommended)
    
    var uiDevice = UIDevice.init()
    // MARK: Properties
    var selectedIndex = -1
    //var cellHeights = [482,276,552,664,482,168]
    var cellHeights = [470,192,552,664,482,94]
    var cellHeightsSmallScreen = [540,200,620,750,510,94]
    
    
    let firstViewHeight:CGFloat = CGFloat(320)
    let firstViewHeightMargin:CGFloat = CGFloat(0)
    let bulletsContentSpacing = 12
    let bulletToNextTitleSpacing = -24
    
    //struct model to hold json data from Timeline.josn: by Madhukar Raj 01/14/2019
    struct TimelineStruct: Decodable {
        let phase: Phase
        let phaseBullet: PhaseBullet
        let photo: String
    }
    
    struct Phase: Decodable {
        let phaseInfo, dateInfo, titleInfo: String
        let phaseBulletSub: [String]
    }
    
    struct PhaseBullet: Decodable {
        let titleOneLabel, titleOneBullet, titleTwoLabel, titleTwoBullet, titleThreeLabel, titleThreeBullet: String?
    }
    var cellItems = [TimelineStruct]() // josn struct model instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Remove separator line between cells
        self.tableView.separatorStyle = .none
        
        // Load the timeline items
        tableView.reloadData()
        
        view.addSubview(countdownClock)
        
        //add the menu
        Menu.layer.zPosition = 2;
        view.addSubview(Menu)
        Menu.frame = CGRect(x:-300, y:0, width: 265, height:self.view.frame.height)
        
        //tap recognizer to close menu
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        self.menuBlur.addGestureRecognizer(tapOut)
        
        //parse json data form Timeline.json: by Madhukar Raj 01/14/2019
        if let timelineDataUrl = Bundle.main.url(forResource: "Timeline", withExtension: "json", subdirectory: "/Data"){
            do {
                let timelinejsonData = try Data(contentsOf: timelineDataUrl)
                let timelineDecoder = JSONDecoder()
                let timelineDecodedData =  try timelineDecoder.decode([TimelineStruct].self, from: timelinejsonData)
                
                cellItems = timelineDecodedData
            }catch let parseError {
                print("Error in parsing json:", parseError)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TimelineItemTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TimelineItemTableViewCell else {
            fatalError("The dequeued cell is not an instance of TimelineItemTableViewCell.")
        }
        
        // Fetches the appropriate TimelineItem for the data source layout.
        let item = cellItems[indexPath.row]
        
        // =====================CELL STYLE ====================
        
        // prevent highlighting when pressed
        cell.selectionStyle = .none
        
        // restore background colors to alpha if not debugging
        if (!debugColors) {
            let transparent : UIColor = UIColor(white: 1, alpha: 0)
            cell.firstView.backgroundColor = transparent
            cell.secondView.backgroundColor = transparent
            cell.dateLabel.backgroundColor = transparent
        }
        
        // rounds corners for imageview
        cell.photoImageView.layer.cornerRadius = 10
        cell.photoImageView.layer.masksToBounds = true
        
        // rotates the date label
        cell.dateLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        // hotfix for title size: makes font size small enough to show all shortened titles
        if (adjustTitleSize) {
            cell.titleLabel.font = cell.titleLabel.font.withSize(23)
        }
        
        // Grab new bulletsLabel height
        if (!fixExpandedCellHeights) {
            if UIDevice.current.screenType == .iPhones_5_5s_5c_SE{
                cellHeightsSmallScreen[indexPath.row] = Int(cell.bulletsLabel.bounds.height)
            }else {
                cellHeights[indexPath.row] = Int(cell.bulletsLabel.bounds.height)
            }
            print("cellHeights: [" + (item.phase.phaseInfo) + "] " + String(cellHeights[indexPath.row]))
        }
        
        // Programatically adjust spacing between bullets content objects
        cell.bulletOneTopConstraint.constant = CGFloat(bulletsContentSpacing)
        cell.bulletTwoTopConstraint.constant = CGFloat(bulletsContentSpacing)
        cell.bulletThreeTopConstraint.constant = CGFloat(bulletsContentSpacing)
        cell.titleOneTopConstraint.constant = CGFloat(bulletsContentSpacing / 2)
        cell.titleTwoTopConstraint.constant = CGFloat(bulletsContentSpacing + bulletToNextTitleSpacing)
        cell.titleThreeTopConstraint.constant = CGFloat(bulletsContentSpacing + bulletToNextTitleSpacing)
        
        
        // ===================CELL DATA =====================
        // modified for json data: by Madhukar Raj 01/14/2019
        cell.dateLabel.text = item.phase.dateInfo
        cell.phaseLabel.text = item.phase.phaseInfo.uppercased()
        cell.titleLabel.text = item.phase.titleInfo.uppercased()
        cell.photoImageView.image = UIImage(named: item.photo)
        
        
        cell.titleOneLabel.text = item.phaseBullet.titleOneLabel!
        cell.bulletsLabel.text = item.phaseBullet.titleOneBullet
        cell.titleTwoLabel.text = item.phaseBullet.titleTwoLabel!
        cell.bulletTwoLabel.text = item.phaseBullet.titleTwoBullet
        cell.titleThreeLabel.text = item.phaseBullet.titleThreeLabel!
        cell.bulletThreeLabel.text = item.phaseBullet.titleThreeBullet
        
        var totalSecondViewHeights = cell.titleOneLabel.bounds.height
        totalSecondViewHeights += cell.titleTwoLabel.bounds.height
        totalSecondViewHeights += cell.titleThreeLabel.bounds.height
        totalSecondViewHeights += cell.bulletsLabel.bounds.height
        totalSecondViewHeights += cell.bulletTwoLabel.bounds.height
        totalSecondViewHeights += cell.bulletThreeLabel.bounds.height
        totalSecondViewHeights += CGFloat((5 * bulletsContentSpacing))
        totalSecondViewHeights += CGFloat((2 * bulletToNextTitleSpacing))
        
        let sectionOneTextHeight:String = String(describing: cell.titleOneLabel.bounds.height + cell.bulletsLabel.bounds.height)
        let sectionTwoTextHeight:String = String(describing: cell.titleTwoLabel.bounds.height + cell.bulletTwoLabel.bounds.height)
        let sectionThreeTextHeight:String = String(describing: cell.titleThreeLabel.bounds.height + cell.bulletThreeLabel.bounds.height)
        let sectionsHeights:String = " { " + sectionOneTextHeight + ", " + sectionTwoTextHeight + ", " + sectionThreeTextHeight + " }"
        let sectionsSpacings:String = " { " + String(describing: CGFloat((5 * bulletsContentSpacing) + (2 * bulletToNextTitleSpacing))) + " }"
        
        print(item.phase.phaseInfo + "]==[: " + String(describing: totalSecondViewHeights) + sectionsHeights + sectionsSpacings)
        
       
        return cell
    }
    
    
    // Functions controlling collapse / expand behavior
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (selectedIndex == indexPath.row) {
            if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
                return firstViewHeight + CGFloat(cellHeightsSmallScreen[indexPath.row])
            }else {
                return firstViewHeight + CGFloat(cellHeights[indexPath.row])
            }
        } else {
            // Collapsed cell height
            return firstViewHeight + firstViewHeightMargin
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selectedIndex \(selectedIndex) : indexPath.row \(indexPath.row)")
        if (selectedIndex == indexPath.row) {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
            
            // Update countdown clock to match phase that was just tapped
            let item = cellItems[selectedIndex]
            countdownClock.changeCountdown(phase: item.phase.phaseInfo, date: item.phase.dateInfo)
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
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
    
    @IBAction func news(_ sender: Any) {
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
