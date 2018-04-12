//
//  UIViewExtensions.swift
//  Psyche
//
//  Created by Rivinis on 2/15/18.
//  Copyright © 2018 ASU. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func fadeIn(duration: TimeInterval, delay: TimeInterval, completion: ((_ finished: Bool) -> Void)?) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: { self.alpha = 1.0 }, completion: completion)
    }
    
    func fadeInTwo(duration: TimeInterval, delay: TimeInterval, completion: ((_ finished: Bool) -> Void)?) {
        self.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: { self.alpha = 0.5 }, completion: completion)
    }
    
    func fillTextZero() -> String {
        let returnString =
            "Launch Date: 2022\n" +
            "Launch Site: Cape Canaveral, Florida\n" +
            "Destination: Main Asteroid Belt\n" +
            "Type: Orbiter\n" +
            "Status: In Development\n" +
            "Nation: United States\n\n" +
            "GOALS:\n\n" +
            "Psyche will explore a unique metal asteroid orbiting the Sun between Mars and Jupiter. Asteroid 16 Psyche appears unique because it might be the exposed nickel-iron core of an early planet, one of the building blocks of our solar system.\n\n" +
            "Deep within rocky, terrestrial planets —including Earth— scientists have detected sings of metallic cores, but these but they are too far below the planets’ mantles and crusts for direct observation. Psyche offers a unique window into the violent history of collisions and accretion that created terrestrial planets.\n\n" +
            "-Accomplishments\n" +
            "This mission is in development.\n\n" +
            "-Key Dates\n" +
            "Mission Timeline:\n" +
            "2022: Launch\n" +
            "2023: Mars Flyby\n" +
            "2026: Arrival at Asteroid Psyche\n" +
            "2026-2027: Orbital Mission\n\n" +
            "-Spacecraft\n" +
            "Launch Vehicle: TBD\n" +
            "Spacecraft Mass: TBD\n\n" +
            "-Spacecraft Instruments:\n" +
            "1. Multispectral Imager.\n" +
            "2. Gamma Ray and Neutron Spectrometer.\n" +
            "3. Magnetometer.\n" +
            "4. X-band Gravity Science Investigation.\n" +
            "______________________"
        
        return returnString
    }
    
    func fillTextOne() -> String {
        let returnString =
            "Arizona State University’s Psyche Mission, a journey to a metal asteroid, has been selected for flight, marking the first time the school will lead a deep-space NASA mission and the first time scientists will be able to see what is believed to be a planetary core.\n\n" +
            "The mission’s spacecraft is expected to launch in 2023, arriving at the asteroid in 2030, where it will spend 20 months in orbit, mapping it and studying its properties.\n\n" +
                "The mission’s spacecraft is expected to launch in 2023, arriving at the asteroid in 2030, where it will spend 20 months in orbit, mapping it and studying its properties.\n\n" +
            "“This mission, visiting the asteroid Psyche, will be the first time humans will ever be able to see a planetary core,” said principal investigator Lindy Elkins-Tanton, director of ASU’s School of Earth and Space Exploration (SESE). “Having the Psyche Mission selected for NASA’s Discovery Program will help us gain insights into the metal interior of all rocky planets in our solar system, including Earth.”\n\n" +
            "Psyche, an asteroid orbiting the sun between Mars and Jupiter, is made almost entirely of nickel-iron metal. As such, it offers a unique look into the violent collisions that created Earth and the other terrestrial planets.\n\n" +
            "The scientific goals of the Psyche mission are to understand the building blocks of planet formation and explore firsthand a wholly new and unexplored type of world. The mission team seeks to determine whether Psyche is a protoplanetary core, how old it is, whether it formed in similar ways to the Earth’s core, and what its surface is like.\n\n" +
            "\"The knowledge this mission will create has the potential to affect our thinking about planetary science for generations to come,\" ASU President Michael M. Crow said. \"We are in a new era of exploration of our solar system with new public-private sector partnerships helping unlock new worlds of discovery, and ASU will be at the forefront of that research.\"\n\n" +
            "PSYCHE — A WINDOW INTO PLANETARY CORES:\n\n" +
            "Every world explored so far by humans (except gas giant planets such as Jupiter or Saturn) has a surface of ice or rock or a mixture of the two, but their cores are thought to be metallic. These cores, however, lie far below rocky mantles and crusts and are considered unreachable in our lifetimes.\n\n" +
            "Psyche, an asteroid that appears to be the exposed nickel-iron core of a protoplanet, one of the building blocks of the sun’s planetary system, may provide a window into those cores. The asteroid is most likely a survivor of violent space collisions, common when the solar system was forming.\n\n" +
            "Psyche follows an orbit in the outer part of the main asteroid belt, at an average distance from the sun of about 280 million miles, or three times farther from the sun than Earth. It is roughly the size of Massachusetts (about 130 miles in diameter) and dense (7,000 kg/m³).\n\n" +
            "“Being selected to lead this ambitious mission to the all-metal asteroid Psyche is a major milestone that reflects ASU’s outstanding research capacity,” said Sethuraman Panchanathan, executive vice president and chief research and innovation officer at ASU. “It speaks to our innovative spirit and our world-class scientific expertise in space exploration.”\n\n" +
            "MISSION INSTRUMENT PAYLOAD:\n\n" +
            "The spacecraft's instrument payload will include magnetometers, multispectral imagers, a gamma ray and neutron spectrometer, and a radio-science experiment.\n\n" +
            "The multispectral imager, which will be led by an ASU science team, will provide high-resolution images using filters to discriminate between Psyche's metallic and silicate constituents. It consists of a pair of identical cameras designed to acquire geologic, compositional and topographic data.\n\n" +
            "The gamma ray and neutron spectrometer will detect, measure and map Psyche's elemental composition. The instrument is mounted on a 7-foot (2-meter) boom to distance the sensors from background radiation created by energetic particles interacting with the spacecraft and to provide an unobstructed field of view. The science team for this instrument is based at the Applied Physics Laboratory at Johns Hopkins University.\n\n" +
            "The magnetometer, which is led by scientists at MIT and UCLA, is designed to detect and measure the remnant magnetic field of the asteroid. It’s composed of two identical high-sensitivity magnetic field sensors located at the middle and outer end of the boom.\n\n" +
            "The Psyche spacecraft will also use an X-band radio telecommunications system, led by scientists at MIT and NASA’s Jet Propulsion Laboratory. This instrument will measure Psyche's gravity field and, when combined with topography derived from onboard imagery, will provide information on the interior structure of the asteroid.\n\n" +
            "THE PSYCHE MISSION TEAM:\n\n" +
            "In addition to Elkins-Tanton, ASU SESE scientists on the Psyche mission team include Jim Bell, deputy principal investigator and co-investigator, co-investigator Erik Asphaug, and co-investigator David Williams.\n\n" +
            "NASA’s Jet Propulsion Laboratory managed by Caltech is the managing organization and will build the spacecraft with industry partner Space Systems Loral (SSL). JPL’s contribution to the Psyche mission team includes over 75 people, led by project manager Henry Stone, project scientist Carol Polanskey, project systems engineer David Oh and deputy project manager Bob Mase. SSL contribution to the Psyche mission team includes over 50 people led by SEP Chassis deputy program manager Peter Lord and SEP Chassis program manager Steve Scott.\n\n" +
            "Other co-investigators are David Bercovici (Yale University), Bruce Bills (JPL), Richard Binzel (Massachusetts Institute of Technology), William Bottke (Southwest Research Institute — SwRI), Ralf Jaumann (Deutsches Zentrum für Luft — und Raumfahrt), Insoo Jun (JPL), David Lawrence (Johns Hopkins University/Applied Physics Laboratory — APL), Simon Marchi (SwRI), Timothy McCoy (Smithsonian Institution), Ryan Park (JPL), Patrick Peplowski (APL), Thomas Prettyman, (Planetary Science Institute), Carol Raymond (JPL), Chris Russell (UCLA), Benjamin Weiss (MIT), Dan Wenkert (JPL), Mark Wieczorek (Institut de Physique du Globe de Paris), and Maria Zuber (MIT).\n" +
            "______________________"
        
        return returnString
    }
    
    func fillTextTwo() -> String {
        let returnString =
            "In the Spring of 2016, I interviewed for a project manager position at ASU’s School of Earth and Space Exploration (SESE). At that time SESE was one of a few finalists vying to win a NASA mission. ASU’s entrant was a mission called Psyche. Psyche’s scope was massive; minimum of 10 years including pre-launch activities, partnering with Jet Propulsion Lab and Space Systems Loral, and years of waiting, analyzing and reporting.\n\n" +
            "I remember when I first heard Lindy (Lindy Elkins-Tanton, SESE’s Director) speak about Psyche and the 500+ page Step 1 proposal to NASA, I immediately started sweating. It is without question the biggest project I have ever even heard of, let alone asked to help manage. This January when NASA officially selected Psyche, those same anxious sweats came back! In the past, I’ve been a part of many projects where, when things went sideways, we would calm everyone by saying “It’s going to be fine! It’s not rocket science!” This time, IT IS ROCKET SCIENCE!\n\n" +
            "[The Psyche mission is a scientific journey to a metal asteroid orbiting the Sun between Mars and Jupiter. What makes the asteroid Psyche unique is that it appears to be the exposed nickel-iron core of an early planet, one of the building blocks of our solar system.\n\n" +
            "GETTING STARTED:\n\n" +
            "Once the announcement that Psyche was selected sank in I thought: Yes, this is really happening. It was time to get to work. As the project manager for ASU’s portion of the Psyche mission, it was time for me to sit down, get organized, and start with the basics. I knew from past project management experience that no matter the size, scope, or type of project, I have to answer a few basic questions:\n\n" +
            "* What are we doing? OMG ROCKET SCIENCE!!! okay okay…\n\n" +
            "* Why are we doing this project? What is our role in this mission?\n\n" +
            "* What is our timeline?\n\n" +
            "My first goal was to start small and work to get answers to these questions from every possible perspective. Working with the stakeholders on the Psyche project is like nothing I’ve encountered before! The team is open to uncovering every detail and digging through every dark corner. We tackled every aspect of our scope to answer questions such as; how will we handle intellectual property (IP) with our capstone students? Government sponsored programs require us to be careful and not profit from IP. Can our contracts team develop an agreement for each participating student to sign? And, how do we successfully partner with JPL to ensure we follow the NASA project management process? JPL will take the lead in this process but we must stay in tight communication with weekly meetings, ad-hoc phone calls, and monthly reports. As I worked with our project’s stakeholders to get answers, the project seemed less scary.\n\n" +
            "With the project’s end in mind and a vision of success, I charted a path forward. All the other aspects of project planning, schedule (scope, roles and responsibilities, etc.) fall into place once you know what, why and when. Often for me taking the first step is the hardest, so getting back to basics and answering simple questions like “WHY?” help me to get organized, motivate teams and ultimately deliver what we promise.\n\n" +
            "NEW KIND OF TEAM:\n\n" +
            "At ASU we needed to create a team that hasn’t existed at the university before. We needed to recruit financial team members to create, edit, manage and track our budget. Because we were going to be managing nine subcontractors we needed to enlist a strong contracts team. The university’s portion of the work includes planning and managing the science team, developing the imager, and design, development, and management of our science data center. Our scope also includes student collaborations and outreach, so we need project team members that help integrate and develop teams of faculty, graduate students, undergrads and postdocs; all of these teams are part of our educational and public outreach. All told we need an interdisciplinary cross-section of stakeholders for ASU to perform our role for our real-life mission to visit an asteroid! This is just the ASU portion of the team. The Psyche spacecraft build and mission management is led by Jet Propulsion Laboratory and our spectacular project manager at JPL is Henry Stone. A further, and critical, aspect of team management for a mission became immediately apparent: integration across our many institutions.\n\n" +
            "The Psyche Mission’s project “phase B” — the preliminary design phase, is in full swing. All the things we said we were going to do are starting to materialize. It’s really happening! When I’m in the day-to-day efforts of working with schedules, budgets, stakeholders and meeting minutes, Psyche often feels like any other project, but when I review the overall timeline or hear words like ‘launch,’ I can’t help to scream in my head OMG ROCKET SCIENCE!!!!! I’m so grateful and excited to be a part of this project!\n" +
            "______________________"
        
        return returnString
    }
    
    func fillTextThree() -> String {
        let returnString =
            "NASA called in a Hollywood illustrator to visualize its next big target: the metal-filled asteroid 16 Psyche.\n\n" +
            "Artist Peter Rubin, a prolific cinematic illustrator, has lent his talents to Hollywood movies ranging from Roland Emmerich's 1994 epic Stargate to the upcoming reboot Spider-Man: Homecoming.\n\n" +
            "But when NASA's Jet Propulsion Laboratory (JPL) asked him to bring his brand of filmic flare to the agency's roster of candidate space missions, Rubin, a self-described space and science geek, jumped at the opportunity.\n\n" +
            "\"The thinking was that it would behoove JPL, in these times when funding for projects is harder to come by, to take advantage of the fact that they are in the Los Angeles area and there's all this cinematic talent around,\" Rubin, who began working with NASA in 2013, told me over the phone.\n\n" +
            "The fruits of this collaboration include gorgeous concept art, illustrations, and animations promoting a mission to 16 Psyche, or simply Psyche, one of the crown jewels of the asteroid belt. For the project, Rubin worked closely with Arizona State University (ASU) planetary scientist Lindy Elkins-Tanton, the mission lead for Psyche, to translate the observational data on this weird metal-rich world into captivating visual representations like this mission trailer.\n\n" +
            "\"The overall shape of the asteroid, including the positioning of those two large craters, is pretty accurate,\" Rubin told me. \"I was given ASU's newly-acquired radar shape data which I translated into a digital mesh. That data is very rough. Then, over that, I sculpted features like the very deep scarps, cliff sides, sulfur fields, volcanoes, craters, and things that might be perceived from a closer vantage point. The overall shape, and positioning of the camera reflects  how Psyche, more or less, would look from our point of view.\"\n\n" +
            "The interdisciplinary efforts of the entire Psyche team paid off, because NASA recently greenlit the mission to this \"new type of world,\" as Elkins-Tanton described it in a teleconference.\n\n" +
            "Measuring about 210 kilometers (130 miles) in diameter, the object is thought to be the raw exposed core of a Mars-sized protoplanet that may have been stripped of its outer layers by devastating collisions with other celestial bodies. This makes it a tantalizing destination for planetary scientists and for commercial interests alike, given Psyche's vast deposits of iron, nickel, and other valuable resources. The announcement of the mission kicked-off a fresh wave of stories about asteroid mining, and there are several organizations actively pursuing such off-planet extractions.\n\n" +
            "But what does this bizarre asteroid actually look like up close? We'll find out when the Psyche spacecraft reaches its target circa 2030, but for the moment, there is much speculation about its appearance. To bridge that gap, Rubin and Elkins-Tanton worked together to interweave hard science with the creative flourish and eye-catching imagery Rubin is known for in the film world.\n\n" +
            "But what does this bizarre asteroid actually look like up close? We'll find out when the Psyche spacecraft reaches its target circa 2030, but for the moment, there is much speculation about its appearance. To bridge that gap, Rubin and Elkins-Tanton worked together to interweave hard science with the creative flourish and eye-catching imagery Rubin is known for in the film world.\n\n" +
            "In this way, Rubin balanced observations of the asteroid with the dramatic visual language of movies. He has employed similar film-centric techniques to other NASA mission concepts, including proposed trips to Mars and Saturn's moons Enceladus and Pandora, drawing inspiration from other vivid science illustrators, such as space art pioneer Chesley Bonestell.\n\n" +
            "\"What I was bringing to the project was a cinematic sensibility,\" Rubin said. \"It requires finish. It's carrying something through from the purely objective to something more natural and emotional. I worked very hard on the Psyche project, in order to get that kind of engagement. To make you feel, as you watch the video, anticipation, a little bit of tension, and some surprise.\"\n\n" +
            "Hopefully, NASA continues to channel the instincts of film insiders in mission concept artwork. Not only does it inspire public engagement, it makes the anticipation of discovering what these distant objects really look like, compared to our imaginings, that much more exciting.\n" +
            "______________________"
        
        return returnString
        
    }
    
}
