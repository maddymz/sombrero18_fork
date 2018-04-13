//
//  TimelineItemTableViewCell.swift
//  PsycheTimeline
//
//  Created by jason on 2/25/18.
//  Copyright © 2018 sombrero. All rights reserved.
//

import UIKit

class TimelineItemTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var secondViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bulletsLabel: UILabel!
    
    @IBOutlet weak var titleOneLabel: UILabel!
    @IBOutlet weak var titleTwoLabel: UILabel!
    @IBOutlet weak var titleThreeLabel: UILabel!
    @IBOutlet weak var bulletTwoLabel: UILabel!
    @IBOutlet weak var bulletThreeLabel: UILabel!
    
    
    
    
    
    @IBOutlet weak var bulletOneTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleTwoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bulletTwoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleThreeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bulletThreeTopConstraint: NSLayoutConstraint!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        bulletsLabel.numberOfLines = 0
        titleOneLabel.numberOfLines = 0
        bulletTwoLabel.numberOfLines = 0
        titleTwoLabel.numberOfLines = 0
        bulletThreeLabel.numberOfLines = 0
        titleThreeLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var showDetails = false {
        didSet {
            secondViewHeightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(showDetails ? 250 : 999))
        }
    }

}
