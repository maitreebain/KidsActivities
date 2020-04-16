//
//  ScavengerInfo.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/16/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

struct ScavengerInfo {
    let title: String
    let image: UIImage?
}

let scavengerItems = [
    ScavengerInfo(title: "A book with the first letter of you name in the title", image: UIImage(named: "book")),
    ScavengerInfo(title: "Stuffed animal", image: UIImage(named: "teddy")),
    ScavengerInfo(title: "Three different colored crayons", image: UIImage(named: "crayons")),
    ScavengerInfo(title: "Clock", image: UIImage(named: "clock")),
    ScavengerInfo(title: "Ball", image: UIImage(named: "ball")),
    ScavengerInfo(title: "Plant", image: UIImage(named: "plant")),
    ScavengerInfo(title: "Socks", image: UIImage(named: "socks")),
    ScavengerInfo(title: "A photo of some you love", image: UIImage(named: "images")),
    ScavengerInfo(title: "Backpack", image: UIImage(named: "backpack")),
    ScavengerInfo(title: "A book with numbers in it", image: UIImage(named: "numberBook"))
]
