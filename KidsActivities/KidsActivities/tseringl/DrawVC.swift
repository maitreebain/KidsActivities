//
//  DrawVC.swift
//  KidsActivities
//
//  Created by Tsering Lama on 4/16/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class DrawVC: UIViewController {
    
    @IBOutlet weak var drawingPad: UIImageView!
    
    public var lastTouch = CGPoint(x: 0, y: 0) // default value
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // calls when touch is sensed
        
        // get first touch
        if let firstTouch = touches.first {
            lastTouch = firstTouch.location(in: view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // users move , or finished moving
        
        if let firstTouch = touches.first {
            let touchedLocation = firstTouch.location(in: view)
            
            // function to draw the lines
            connectLines(firstTouch: lastTouch, lastTouch: touchedLocation)
            lastTouch = touchedLocation
        }
    }
    
    private func connectLines(firstTouch: CGPoint, lastTouch: CGPoint) {
        
    }


}
