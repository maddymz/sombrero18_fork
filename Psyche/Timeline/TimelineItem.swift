//
//  TimelineItem.swift
//  PsycheTimeline
//
//  Created by jason on 2/28/18.
//  Copyright © 2018 sombrero. All rights reserved.
//

import UIKit

class TimelineItem {
    // MARK: Properties
    var date: String
    var phase: String?
    var title: String
    var bullets: [[String]]
    var photo: UIImage?
    
    // MARK: Initialization
    init?(date: String, phase: String?, title: String, bullets: [[String]], photo: UIImage?) {
        // Fail if fields missing
        if date.isEmpty || title.isEmpty || bullets.isEmpty {
            return nil
        }
        
        // Initialize stored properties.
        self.date = date
        self.phase = phase
        self.title = title
        self.bullets = bullets
        self.photo = photo
    }
}
