//
//  data+gallery.swift
//  Psyche
//
//  Created by Samuel Lam on 4/10/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation

public var selected:Int = 0

//assetNames
public var imageArray = [
"4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19"]



//captions Dicitionary
public var captions : [Int:String]  = [
    4 : "This cross stitch is based off the current artist rendering of the Psyche asteroid. Abigail Weibel chose to exaggerate the image by using a lot of color to help it pop off the black background (and because there are only so many choices of grey thread!).",
    5 : "Brianna Orrill created street art for ASU’s Earth and Space Exploration Day on November 18th. This piece contained half of the Psyche satellite, with accurate dimensions to show the public the size. I filled in the entirety of the bus (body) of the spacecraft. For the solar panels, however, Brianna invited kids (of all ages!) at the event to participate: Each person got a small cup of chalk and a square foot to draw any image of space that they wanted.",
    6 : "Caption 6",
    7 : "Caption 7",
    8 : "Caption 8",
    9 : "This work is inspired by the colors of the Psyche mission badge and the overall journey of the Psyche mission. This reflects all the people who have put in the time to push for the future of this mission.",
    10 : "Caption 10",
    11 : "This work was inspired by Luke Dubois’ Hindsight is Always 20/20 project. Anne Norenberg made a Psyche Stylized Snellen eye chart, which helps determine a patient’s eyesight from the ability to measure the distance from the chart while reading the letters. She also took words that were important to the Psyche mission and included them as the lines on the eye chart.",
    12 : "Caption 12",
    13 : "Caption 13",
    14 : "This stop motion shows Psyche leaving Earth, passing the Moon, Mars, and a few meteoroids on its way to Psyche. All pieces were hand-cut from weighted cardstock. Dimensions of the Psyche spacecraft are 2” x 0.75”. The music is a piece called “Ideas” written by fellow Psyche Inspired intern Isaac Wisdom! Cinematography by Matthew Berger.",
    15 : "Caption 15",
    16 : "Kari Sanford wanted to tell the stories of the minds and hearts behind the Psyche Mission. With the team’s help, she approached scientists, engineers, journalists, and students associated with this mission and solicited their feedback. All of the words/phrases in this word cloud are their own. The most frequent, and inspiring, feedback was, ‘More than me,’ or ‘Bigger than me.’ This mission has helped people look beyond their own skillset and find ways to help others grow. Psyche has created a community through engagement: we are all connected through our pursuit of knowledge in deep space.",
    17 : "",
    18 : "Backyard Telescope represents the accessibility of the asteroid (16) Psyche to scientists and non-scientists alike because of the Psyche Mission. Images and information collected during NASA-led missions are made available as part of the public domain, allowing amateur astronomers a chance to learn about space. This diorama returns to a childlike fascination with exploration and learning.",
    19 : "With Psyche, you never have to take down your holiday lights! Inspired by festive holiday light sculptures, Chris Vasquez wanted to create something reminiscent of those while keeping true to the design of Psyche."
]

public var dates : [Int:String] = [
    4 : "03/19/2018",
    5 : "12/02/2017",
    6 : "Date 6",
    7 : "Date 7",
    8 : "Date 8",
    9 : "03/16/2018",
    10 : "Date 10",
    11 : "02/20/2018",
    12 : "Date 12",
    13 : "Date 13",
    14 : "03/16/2018",
    15 : "Date 15",
    16 : "Date 16",
    17 : "",
    18 : "04/02/2018",
    19 : "03/21/2018"
]

//when accessing Dictionaries, if the key doesnt exsist, then returns nil
//for example
//
//  if let airportName = airports["DUB"] {
//  print("The name of the airport is \(airportName).")
//  } else {
//      print("That airport is not in the airports dictionary.")
//  }
public var isVideo : [Int:Bool] = [
    1:true
]
