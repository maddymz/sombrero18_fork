//
//  HtmlExtension.swift
//  Psyche
//
//  Created by psyche-admin on 1/28/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import Foundation
import UIKit

var urlSubString: Any = ""
//extension to convert the html content form api resopnse to string: by Madhukar Raj 01/28/2019
extension String{

    func convertHtml(family: String?, size: CGFloat) -> NSAttributedString? {
        do{
            var htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                "text-align: justify;" +
            "}</style> \(self)"
            
            let htmlStringArray = htmlCSSString.split(separator: "<")
            for element in htmlStringArray {
                if element.contains("https"){
                    let urlSub = element
                    let newUrl = urlSub.split(separator: "\"")
                    print("url array", newUrl)
                    for item in newUrl {
                        if item.contains("https") {
                            var finalUrl = item.split(separator: "?")
                            urlSubString = finalUrl[0]
                        }
                    }
                }
            }
            print("htmlstring", htmlCSSString)
            if htmlCSSString.contains("<if"){
                let startindex = htmlCSSString.index(of: "<if")
                let endindex = htmlCSSString.index(of: "></p>")
                htmlCSSString.removeSubrange(startindex!...endindex!)
                let anchorTag = "<a class=" + "link" + " " +  "href=\(urlSubString)" + " " + "target=" + "_blank" + " " + "rel=noopener noreferrer" + ">View the full video</a>"
                
                htmlCSSString.replaceSubrange(startindex!..<htmlCSSString.endIndex, with: anchorTag)
            }
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            print("htmlStringData", htmlCSSString.data)
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
}
