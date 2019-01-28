//
//  HtmlExtension.swift
//  Psyche
//
//  Created by psyche-admin on 1/28/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Foundation
import UIKit

//extension to convert the html content form api resopnse to string: by Madhukar Raj 01/28/2019
extension String{
    func convertHtml(family: String?, size: CGFloat) -> NSAttributedString? {
        do{
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                "text-align: justify;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
}
