//
//  ActivityObject.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation

struct Activity: Comparable {
    static func < (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
    
    let activityName: String
    var personifiedObject: String?
    let id = UUID().uuidString
    let imageData: Data?
    let videoData: Data?
    let videoURL: URL?
    let date = Date()
}
