//
//  TimelineTableViewController.swift
//  PsycheTimeline
//
//  Created by jason on 2/28/18.
//  Copyright © 2018 sombrero. All rights reserved.
//

import UIKit
import Foundation

class TimelineTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //timeline tableview
    @IBOutlet weak var tableView: UITableView!
    
    //Menu
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    // Countdown clock
    let countdownClock = CountdownClockTimeline(frame: CGRect(x: 0, y: 64, width: 375, height: 61))
    
    // MARK: Demo Options
    let debugColors = false // set to true to keep colorful ui element bgs, false to change all bgs to transparent
    let shortenTitles = true // set to true to shorten titles, false to keep original
    let adjustTitleSize = true // set to true to set title font size to 23, false to keep original
    let fixExpandedCellHeights = true // set to true to fix cell heights to predetermined values, false to adjust dynamically (not recommended)
    
    
    // MARK: Properties
    var selectedIndex = -1
    var items = [TimelineItem]()
    //var cellHeights = [482,276,552,664,482,168]
    var cellHeights = [470,192,552,664,482,94]
    let firstViewHeight:CGFloat = CGFloat(320)
    let firstViewHeightMargin:CGFloat = CGFloat(0)
    let bulletsContentSpacing = 12
    let bulletToNextTitleSpacing = -24
    
    //struct model to hold json data form Timeline.josn: by Madhukar Raj 01/14/2019
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
        let titleOneLabel, phaseBulletTitleOneBullet: String?
        let titleTwoLabel, titleTwoBullet, titleThreeLabel, titleThreeBullet: String
        let titleOneBullet, titleOne, tittleOneBullet: String?
        
        enum CodingKeys: String, CodingKey {
            case titleOneLabel
            case phaseBulletTitleOneBullet = "titleOneBullet"
            case titleTwoLabel, titleTwoBullet, titleThreeLabel, titleThreeBullet
            case titleOneBullet = "TitleOneBullet"
            case titleOne, tittleOneBullet
        }
    }
    
    var cellItems = [TimelineStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Remove separator line between cells
        self.tableView.separatorStyle = .none
        
        // Load the timeline items
//        loadTimelineItems()
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
                print("timeline JSON data", timelineDecodedData)
                
                print("item count" , timelineDecodedData.count)
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

    // MARK: - Table view data source

    
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
        print("one cell item:   ", item)
        
        
        // CELL STYLE ========
        
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
            cellHeights[indexPath.row] = Int(cell.bulletsLabel.bounds.height)
            print("cellHeights: [" + (item.phase.phaseInfo) + "] " + String(cellHeights[indexPath.row]))
        }
        
        // Programatically adjust spacing between bullets content objects
        cell.bulletOneTopConstraint.constant = CGFloat(bulletsContentSpacing)
        cell.bulletTwoTopConstraint.constant = CGFloat(bulletsContentSpacing)
        cell.bulletThreeTopConstraint.constant = CGFloat(bulletsContentSpacing)
        cell.titleOneTopConstraint.constant = CGFloat(bulletsContentSpacing / 2)
        cell.titleTwoTopConstraint.constant = CGFloat(bulletsContentSpacing + bulletToNextTitleSpacing)
        cell.titleThreeTopConstraint.constant = CGFloat(bulletsContentSpacing + bulletToNextTitleSpacing)
        
        
        // CELL DATA ========
        
        cell.dateLabel.text = item.phase.dateInfo
        cell.phaseLabel.text = item.phase.phaseInfo
        cell.titleLabel.text = item.phase.titleInfo
        cell.photoImageView.image = UIImage(named: item.photo)
        
        
        cell.titleOneLabel.text = item.phaseBullet.titleOneLabel
        cell.bulletsLabel.text = item.phaseBullet.titleOneBullet
        cell.titleTwoLabel.text = item.phaseBullet.titleTwoLabel
        cell.bulletTwoLabel.text = item.phaseBullet.titleTwoBullet
        cell.titleThreeLabel.text = item.phaseBullet.titleThreeLabel
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
        
        //cell.firstViewHeightConstraint.constant = CGFloat(cell.showDetails ? 324 : 300)
       
        return cell
    }
    
    
    // Functions controlling collapse / expand behavior
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (selectedIndex == indexPath.row) {
            // Total expanded cell height
            // return firstViewHeight + firstViewHeightMargin + 240 // default height
            //countdownClock.changeCountdown(phase: items[indexPath.row].phase!, date: items[indexPath.row].date)
            return firstViewHeight + CGFloat(cellHeights[indexPath.row])
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
            let item = items[selectedIndex]
            countdownClock.changeCountdown(phase: item.phase!, date: item.date)
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Private Methods
//    private func loadTimelineItems() {
//        let dates = [
//            TextContent.PhaseA[1],
//            TextContent.PhaseB[1],
//            TextContent.PhaseC[1],
//            TextContent.PhaseD[1],
//            TextContent.PhaseE[1],
//            TextContent.PhaseF[1]
//        ]
//        let phases = [
//            TextContent.PhaseA[0],
//            TextContent.PhaseB[0],
//            TextContent.PhaseC[0],
//            TextContent.PhaseD[0],
//            TextContent.PhaseE[0],
//            TextContent.PhaseF[0]
//        ]
//        let titles = [
//            TextContent.PhaseA[2],
//            TextContent.PhaseB[2],
//            TextContent.PhaseC[2],
//            TextContent.PhaseD[2],
//            TextContent.PhaseE[2],
//            TextContent.PhaseF[2]
//        ]
//        let shortenedTitles = [
//            TextContent.PhaseA[2],
//            "Preliminary Design",
//            "Critical Design & Build",
//            "Build & Assembly",
//            TextContent.PhaseE[2],
//            TextContent.PhaseF[2],
//        ]
//
//        /*
//        var varbullets = titles
//        var tempbullet:String = ""
//        for i in 0 ... TextContent.PhaseABullets.count - 1 {
//            tempbullet += "\u{2022} " + TextContent.PhaseABullets[i] + "\n"
//        }
//        varbullets += [tempbullet]
//        */
//
//        let bulletCharacter : String = "\u{2022}"
//        let prefix : String = ""
//        let delimiter : String = "\n\n"
//
//        var varbullets = [String]()
//        for i in 0 ... 5 {
//            var tempBullet : String = ""
//            for j in 0 ... TextContent.AllBullets[i].count - 1 {
//                tempBullet += prefix + TextContent.AllBullets[i][j] + delimiter
//                print("BULLET: " + tempBullet)
//            }
//            varbullets += [tempBullet]
//        }
//        // Add additional info for Phase D and E (workaround for complex bullet structures)
//        varbullets[3] += "-\n" + TextContent.PhaseDSubA[1] + "\n" + TextContent.PhaseDSubA[0].uppercased() + "\n"
//        for i in 0 ... TextContent.PhaseDSubABullets.count - 1 {
//            varbullets[3] += prefix + TextContent.PhaseDSubABullets[i] + delimiter
//        }
//        varbullets[3] += "-\n" + TextContent.PhaseDSubB[1] + "\n" + TextContent.PhaseDSubB[0].uppercased() + "\n"
//        for i in 0 ... TextContent.PhaseDSubBBullets.count - 1 {
//            varbullets[3] += prefix + TextContent.PhaseDSubBBullets[i] + delimiter
//        }
//        varbullets[4] += "-\n" + TextContent.PhaseESubA[1] + "\n" + TextContent.PhaseESubA[0].uppercased() + "\n"
//        for i in 0 ... TextContent.PhaseESubABullets.count - 1 {
//            varbullets[4] += prefix + TextContent.PhaseESubABullets[i] + delimiter
//        }
//        varbullets[4] += "-\n" + TextContent.PhaseESubB[1] + "\n" + TextContent.PhaseESubB[0].uppercased() + "\n"
//        for i in 0 ... TextContent.PhaseESubBBullets.count - 1 {
//            varbullets[4] += prefix + TextContent.PhaseESubBBullets[i] + delimiter
//        }
//        //print(varbullets)
//
//        // Reformatted version
//        var reformattedBullets : [[[String]]] =
//        [
//            [ ["", ""], ["", ""], ["", ""] ],
//            [ ["", ""], ["", ""], ["", ""] ],
//            [ ["", ""], ["", ""], ["", ""] ],
//            [ ["", ""], ["", ""], ["", ""] ],
//            [ ["", ""], ["", ""], ["", ""] ],
//            [ ["", ""], ["", ""], ["", ""] ],
//        ]
//        for i in 0 ... 5 { // Iterate through phases
//            //let currentPhase = TextContent.ReformattedBullets[i]
//            for j in 0 ... 2 { // Iterate through title/bullet pairs
//                let currentPair = TextContent.ReformattedBullets[i][j]
//                reformattedBullets[i][j][0] = currentPair[0]    // assign title
//                for k in 1 ... currentPair.count - 1 {
//                    reformattedBullets[i][j][1] += prefix + currentPair[k] + delimiter  // build up bullet
//                }
//            }
//        }
//
//
//        // Old bullets code block using only the first bullet of each phase description.
//        /*
//        let bullets = [
//            TextContent.PhaseABullets[0],
//            TextContent.PhaseBBullets[0],
//            TextContent.PhaseCBullets[0],
//            TextContent.PhaseDBullets[0],
//            TextContent.PhaseEBullets[0],
//            TextContent.PhaseFBullets[0]
//        ]
//        */
//
//        let photos = [
//            UIImage(named: "team"),
//            UIImage(named: "satellite"),
//            UIImage(named: "diagram"),
//            UIImage(named: "hibay"),
//            UIImage(named: "trajectory"),
//            UIImage(named: "nov_2027"),
//        ]
//
//        // toggle between full titles and shortened titles
//        var titlepick = titles
//        if (shortenTitles) {
//            titlepick = shortenedTitles
//        }
//
//        /*
//        let photo1 = UIImage(named: "asteroid")
//        let bullet1 = TextContent.PhaseABullets[0]
//        guard let item1 = TimelineItem(date: "Sept 2015 - Dec 2016", phase: "PHASE A", title: "CONCEPT STUDY", bullets: bullet1, photo: photo1) else {
//            fatalError("Unable to instantiate item1")
//        }
//         */
//
//        for i in 0...5 {
//            guard let item = TimelineItem(date: dates[i], phase: phases[i].uppercased(), title: titlepick[i].uppercased(), bullets: reformattedBullets[i], photo: photos[i]) else {
//                fatalError("Unable to instantiate item \(i)")
//            }
//            items += [item]
//        }
//
//        //items += [item1]
//    }
    
    
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
