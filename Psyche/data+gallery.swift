//
//  data+gallery.swift
//  Psyche
//
//  Created by Samuel Lam on 4/10/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation

public var selected:Int = 0
public var playing:Bool = false

//assetNames
public var imageArray = [
"ONe","10","5","output","8","9","loop","11","12","13","7","15","16","17","18","19","4","6"]

//1,4,7 are videos
//which is 4,7,10 in captions
//0,3,6 in isVideo



//captions Dicitionary
public var captions : [Int:String]  = [
    20 : "This cross stitch is based off the current artist rendering of the Psyche asteroid. Abigail Weibel chose to exaggerate the image by using a lot of color to help it pop off the black background (and because there are only so many choices of grey thread!).",
    5 : "The Psyche mission will test a sophisticated new laser communication technology that encodes data in photons (rather than radio waves) to communicate between a probe in deep space and Earth. Using light instead of radio allows the spacecraft to communicate more data in a given amount of time. The DSOC team is based at the Jet Propulsion Laboratory.",
    21 : "The Psyche mission team at Space System Loral in Palo Alto, California.",
    7 : "In 2026, an unmanned NASA spacecraft is scheduled to arrive at 16 Psyche, a massive, metallic asteroid floating somewhere between the orbits of Mars and Jupiter. Why is NASA so interested in this heavy metal asteroid? Are we going to mine all that metal, or build a giant space magnet? Linda T. Elkins-Tanton explains how the real answer can be found right under our feet. \nLesson by Linda T. Elkins-Tanton, animation by Eoin Duffy.",
    8 : "The Psyche mission will use the X-band radio telecommunications system to measure Psyche’s gravity field to high precision. When combined with topography derived from onboard imagery, this will provide information on the interior structure of Psyche. The team is based at MIT and JPL.",
    9 : "This work is inspired by the colors of the Psyche mission badge and the overall journey of the Psyche mission. This reflects all the people who have put in the time to push for the future of this mission.",
    6 : "Brianna Orrill created street art for ASU’s Earth and Space Exploration Day on November 18th. This piece contained half of the Psyche satellite, with accurate dimensions to show the public the size. I filled in the entirety of the bus (body) of the spacecraft. For the solar panels, however, Brianna invited kids (of all ages!) at the event to participate: Each person got a small cup of chalk and a square foot to draw any image of space that they wanted.",
    11 : "This work was inspired by Luke Dubois’ Hindsight is Always 20/20 project. Anne Norenberg made a Psyche Stylized Snellen eye chart, which helps determine a patient’s eyesight from the ability to measure the distance from the chart while reading the letters. She also took words that were important to the Psyche mission and included them as the lines on the eye chart.",
    12 : "The Gamma Ray and Neutron Spectrometer will detect, measure, and map Psyche’s elemental composition. The instrument is mounted on a 2-m boom to distance the sensors from background radiation created by energetic particles interacting with the spacecraft and to provide an unobstructed field of view. The team is based at the Applied Physics Laboratory at Johns Hopkins University.",
    13 : "The Psyche Magnetometer is designed to detect and measure the remanent magnetic field of the asteroid. It is composed of two identical high-sensitivity magnetic field sensors located at the middle and outer end of a 2-m (6-foot) boom. The team is based at Massachusetts Institute of Technology and the University of California Los Angeles.",
    10 : "This stop motion shows Psyche leaving Earth, passing the Moon, Mars, and a few meteoroids on its way to Psyche. All pieces were hand-cut from weighted cardstock. Dimensions of the Psyche spacecraft are 2” x 0.75”. The music is a piece called “Ideas” written by fellow Psyche Inspired intern Isaac Wisdom! Cinematography by Matthew Berger.",
    15 : "The Multispectral Imager provides high-resolution images using filters to discriminate between Psyche’s metallic and silicate constituents. The instrument consists of a pair of identical cameras designed to acquire geologic, compositional, and topographic data. The purpose of the second camera is to provide redundancy for mission-critical optical navigation. The team is based at Arizona State University.",
    16 : "Kari Sanford wanted to tell the stories of the minds and hearts behind the Psyche Mission. With the team’s help, she approached scientists, engineers, journalists, and students associated with this mission and solicited their feedback. All of the words/phrases in this word cloud are their own. The most frequent, and inspiring, feedback was, ‘More than me,’ or ‘Bigger than me.’ This mission has helped people look beyond their own skillset and find ways to help others grow. Psyche has created a community through engagement: we are all connected through our pursuit of knowledge in deep space.\n\n",
    17 : "This work underscores the mysterious nature of the asteroid and the importance of the mission. It emphasizes that our current images and predictions about the asteroid are useful, but ultimately can be distortions, not unlike the images made here. Exploration attempts to reconcile this divide between reality and knowledge. To create this work, Megan Bromley converted a pixelated image of (16) Psyche into a sound file, applied 16 different combinations of sound filters to the file, converted those 16 results back to image files, and added each edit as a tile in a larger grid of 16 images. Taped over the top is an accompanying collage poem.",
    18 : "Backyard Telescope represents the accessibility of the asteroid (16) Psyche to scientists and non-scientists alike because of the Psyche Mission. Images and information collected during NASA-led missions are made available as part of the public domain, allowing amateur astronomers a chance to learn about space. This diorama returns to a childlike fascination with exploration and learning.",
    19 : "With Psyche, you never have to take down your holiday lights! Inspired by festive holiday light sculptures, Chris Vasquez wanted to create something reminiscent of those while keeping true to the design of Psyche.",
    4 : "Psyche is both the name of an asteroid orbiting the Sun between Mars and Jupiter — and the name of a NASA space mission to visit that asteroid, led by Arizona State University. Join the Psyche team to explore why this mission was selected for NASA’s Discovery Program, how we’ll get to the asteroid, what we hope to learn from Psyche, and the importance of scientific discovery. Credits: NASA/JPL-Caltech/Arizona State Univ./Peter Rubin/SSL",
    14 : "This artist’s conception shows the Psyche spacecraft near the surface of the Psyche asteroid."
]

public var dates : [Int:String] = [
    20 : "03/19/2018 - Abigail Weibel",
    5 : "02/08/2018 - Arizona State University",
    21 : "2017 - NASA/Arizona State University",
    7 : "01/29/2018 - Ted-Ed, Linda T. Elkins-Tanton",
    8 : "02/08/2018 - Arizona State University",
    9 : "03/16/2018 - Sofia Garcia",
    10 : "03/16/2018 - Nikka Bacalzo",
    11 : "02/20/2018 - Anne Norenberg",
    12 : "02/08/2018 - Arizona State University",
    13 : "02/08/2018 - Arizona State University",
    14 : "01/10/2018 - SSL/ASU/Peter Rubin",
    15 : "02/08/2018 - Arizona State University",
    16 : "03/28/2018  - Kari Sanford",
    17 : "12/02/2017 - Megan Bromley",
    18 : "04/02/2018 - Caralie Cedarleaf",
    19 : "03/21/2018 - Chris Vasquez",
    4 : "04/13/2018 - NASA/JPL-Caltech/Arizona State Univ./Peter Rubin/SSL",
    6 : "12/02/2017 - Brianna Orrill"
]

//when accessing Dictionaries, if the key doesnt exsist, then returns nil
//for example
//
//  if let airportName = airports["DUB"] {
//  print("The name of the airport is \(airportName).")
//  } else {
//      print("That airport is not in the airports dictionary.")
//  }
// 0, 3, 6, 15

public var isVideo : [Int:Bool] = [
    0:true,    //
    1:false,
    2:false,
    3:true,
    4:false,
    5:false,     //
    6:true,     //
    7:false,
    8:false,
    9:false,
    10:false,
    11:false,
    12:false,
    13:false,
    14:false,    //
    15:false,
    16:false,
    17:false,
    18:false
]

public var videoName : [Int:String] = [
    0:"videoplayback",
    3:"videoplayback (1)",
    6:"stop"
]

public var videoType : [Int:String] = [
    0:"mp4",
    3:"mp4",
    6:"mp4"
]
