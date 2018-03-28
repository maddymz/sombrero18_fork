//
//  TextContent.swift
//  ISTimelineDemo
//
//  Created by Jason Price on 2/22/18.
//  TextContent: contains all text content for the Psyche mission timeline.
//  This is a public (open) class with static members accessible like this:
//      let sampleText = TextContent.PhaseA[0]
//

import Foundation

open class TextContent {
    static let PhaseA = [
        "Phase A",
        "Sept 2015 - Dec 2016",
        "Concept Study"
        ]
    static let PhaseABullets = [
        "In September of 2015, the Psyche Mission (as it was proposed in Step 1) was selected by NASA to develop a detailed concept study for consideration for NASA’s Discovery Program. (Step 1 is the initial proposal stage; the team had been working on the idea since 2011 and submitted a 256 page Step 1 proposal that was selected for the Phase A concept study.)",
        "A large team worked on the study, led by the Principal Investigator, Lindy Elkins-Tanton, and consisting of an expansive team that included scientists, engineers, project managers, schedulers, financial modelers, graphic designers, and marketing leads from ASU, JPL, SSL, as well as more than a dozen other universities and research organizations.",
        "In November of 2016, the team presented the proposed mission to 30 NASA reviewers during a nine-hour “site visit” which included a tour of SSL’s high bay, where the Psyche chassis will be built.",
        "The site visit is an intense, highly technical in-person review done by a select group of science, technical, and industry experts. They review every detail of the proposed mission, from concept and design, to execution and science application, as well as how the mission personnel from different institutions work together as a team."
        ]
    static let PhaseB = [
        "Phase B",
        "Jan 2017 - May 2019",
        "Preliminary Design of All Instruments & Spacecraft"
    ]
    static let PhaseBBullets = [
        "Science and engineering teams on the mission are designing the spacecraft and the instruments that will be used to analyze the asteroid.",
        "March 2019, the team will undergo project and flight system Preliminary Design Review.",
        "May 2019, the team reaches Key Decision Point C, which will give the team the official approval to move to the next phase (Phase C)."
    ]
    static let PhaseC = [
        "Phase C",
        "May 2019 - Jan 2021",
        "Critical Design & Build of All Instruments & Spacecraft"
    ]
    static let PhaseCBullets = [
    	"Science and engineering teams begin to build their instruments.",
        "The instruments consist of a magnetometer, a multispectral imager, and a gamma ray and neutron spectrometer.",
        "The mission will use an X-band radio telecommunications system to measure Psyche’s gravity field to high precision. When combined with topography derived from onboard imagery, this will provide information on the interior structure of Psyche.",
        "The mission will also test a sophisticated new laser communication technology that encodes data in photons (rather than radio waves) to communicate between a probe in deep space and Earth. Using light instead of radio allows the spacecraft to communicate more data in a given amount of time.",
        "April 2020, the teams will undergo Project and Flight System Critical Design Review, this is an integral step in the instrument engineering process.",
        "The bus or “body” of the spacecraft will be completed by May 2020.",
        "In January 2021, the team will conduct the Systems Integration Review to ensure that the system is ready to be integrated. The last step in Phase C is Key Decision Point D that will give the team the official approval to move to the next phase."
    ]
    static let PhaseD = [
        "Phase D",
        "Jan 2021 - July 2022",
        "Instrument & Spacecraft Build & Assembly"
    ]
    static let PhaseDBullets = [
        "During this phase, all the spacecraft subsystems are integrated onto the spacecraft bus.",
        "The spacecraft undergoes vibration testing.",
        "The spacecraft undergoes environmental thermal-vacuum testing.",
        "The spacecraft undergoes electromagnetic interference, electromagnetic compatibility testing.",
        "In May 2022 the team will conduct the Operations Readiness Review to ensure the system, procedures, and all supporting software and personnel are ready and fully operational. Before launch, the team will conduct Key Decision Point E that will determine readiness to conduct post launch operations."
    ]
    static let PhaseDSubA = [
        "Spacecraft Ships to Launch Site",
        "May 2022"
    ]
    static let PhaseDSubABullets = [
    "The Psyche spacecraft, now fully assembled, includes solar panels, which fold during transport and launch.",
    "The spacecraft measures about 81 feet long (24.76 meters) when the solar panels are unfolded. This is about the size of a singles tennis court.",
    "The body of the spacecraft is about 10 feet long (3.1 meters) and almost eight feet (2.4 meters) wide."
    ]
    static let PhaseDSubB = [
        "Launch",
        "Aug 2022"
    ]
    static let PhaseDSubBBullets = [
        "At the launch site the team will conduct an entire re-check of the spacecraft before integrating into the launch vehicle.",
        "The spacecraft will launch August of 2022.",
        "Once in space, the spacecraft will travel using solar-electric propulsion.",
        "It will arrive at the asteroid, located in the main asteroid belt between Mars and Jupiter, in early January of 2026."
    ]
    static let PhaseE = [
        "Phase E",
        "May 2023",
        "Mars Gravity Assist"
    ]
    static let PhaseEBullets = [
        "Phase E begins after the Post Launch Assessment Review is conducted.",
        "The spacecraft will use the gravity of Mars to increase speed and to set its trajectory to intersect with Psyche’s orbit around the Sun.",
        "It does this by entering and leaving the gravitational field of Mars.",
        "This slingshot maneuver will save propellant, time and expense."
    ]
    static let PhaseESubA = [
        "Arrival at Psyche",
        "Jan 2026"
    ]
    static let PhaseESubABullets = [
        "Leading up to arrival at Psyche, the spacecraft will spend 100 days in the approach phase",
        "The spacecraft will also measure the asteroid’s spin axis and rotation."
    ]
    static let PhaseESubB = [
        "Orbiting Psyche",
        "Jan 2026 - Oct 2027"
    ]
    static let PhaseESubBBullets = [
        "The spacecraft will orbit the asteroid for 21 months.",
        "It will perform science operations from four different orbits, each successively closer to the asteroid.",
        "In each orbit, the instruments on board will send data back to Earth to be analyzed by the mission’s science team."
    ]
    static let PhaseF = [
        "Phase F",
        "Nov 2027 - Aug 2028",
        "Mission Closeout"
    ]
    static let PhaseFBullets = [
        "In this final phase, the mission team will provide all remaining deliverables and safely decomission the space flight systems."
    ]
    static let AllBullets = [
        PhaseABullets,
        PhaseBBullets,
        PhaseCBullets,
        PhaseDBullets,
        PhaseEBullets,
        PhaseFBullets
    ]
    static let Titles = [
        [ // Phase A
            "Mission Selected",
            "Proposed Mission",
            ""
        ],
        [ // Phase B
            "Instruments & Spacecraft",
            "",
            ""
        ],
        [ // Phase C
            "Critial Build",
            "Instruments",
            "Critical Design Review"
        ],
        [ // Phase D
            "Instrument & Spacecraft",
            PhaseDSubA[0],
            PhaseDSubB[0]
        ],
        [ // Phase E
            "Using Gravity",
            PhaseESubA[0],
            PhaseESubB[0]
        ],
        [ // Phase F
            "Final Phase",
            "",
            ""
        ]
    ]
    static let ReformattedBullets = [
        [ // Phase A
            [
                Titles[0][0],
                PhaseABullets[0],
                PhaseABullets[1]
            ],
            [
                Titles[0][1],
                PhaseABullets[2],
                PhaseABullets[3]
            ],
            [
                Titles[0][2],
                ""
            ]
        ],
        [ // Phase B
            [
                Titles[1][0],
                PhaseBBullets[0],
                PhaseBBullets[1],
                PhaseBBullets[2]
            ],
            [
                Titles[1][1],
                ""
            ],
            [
                Titles[1][2],
                ""
            ]
        ],
        [ // Phase C
            [
                Titles[2][0],
                PhaseCBullets[0],
                PhaseCBullets[1]
            ],
            [
                Titles[2][1],
                PhaseCBullets[2],
                PhaseCBullets[3]
            ],
            [
                Titles[2][2],
                PhaseCBullets[4],
                PhaseCBullets[5],
                PhaseCBullets[6]
            ]
        ],
        [ // Phase D
            [
                Titles[3][0],
                PhaseDBullets[0],
                PhaseDBullets[1],
                PhaseDBullets[2],
                PhaseDBullets[3],
                PhaseDBullets[4]
            ],
            [
                Titles[3][1],
                PhaseDSubABullets[0],
                PhaseDSubABullets[1],
                PhaseDSubABullets[2]
            ],
            [
                Titles[3][2],
                PhaseDSubBBullets[0],
                PhaseDSubBBullets[1],
                PhaseDSubBBullets[2],
                PhaseDSubBBullets[3]
            ]
        ],
        [ // Phase E
            [
                Titles[4][0],
                PhaseEBullets[0],
                PhaseEBullets[1],
                PhaseEBullets[2],
                PhaseEBullets[3]
            ],
            [
                Titles[4][1],
                PhaseESubABullets[0],
                PhaseESubABullets[1]
            ],
            [
                Titles[4][2],
                PhaseESubBBullets[0],
                PhaseESubBBullets[1],
                PhaseESubBBullets[2]
            ]
        ],
        [ // Phase F
            [
                Titles[5][0],
                PhaseFBullets[0]
            ],
            [
                Titles[5][1],
                ""
            ],
            [
                Titles[5][2],
                ""
            ]
        ],
    ]
}























