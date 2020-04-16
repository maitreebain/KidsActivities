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
    
    public var lastTouch = CGPoint(x: 0, y: 0)
    
    public var arrLines = [[CGPoint]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // calls when touch is sensed
        
        // get first touch
        if let firstTouch = touches.first {
            lastTouch = firstTouch.location(in: view)
            arrLines.append([lastTouch])
        }
    }
    
    public func undo() {
       _ =  arrLines.popLast()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // users move , or finished moving
        
        if let firstTouch = touches.first {
            let touchedLocation = firstTouch.location(in: view)
            
            guard var lastLine = arrLines.popLast() else {return}
            lastLine.append(touchedLocation)
            
            arrLines.append(lastLine)
            
            
            // function to draw the lines
            connectLines(firstTouch: lastTouch, lastTouch: touchedLocation)
            lastTouch = touchedLocation
        }
        
    }
    
    
    private func connectLines(firstTouch: CGPoint, lastTouch: CGPoint) {
        // create an image
        // make an image by using the image view itself
        UIGraphicsBeginImageContext(drawingPad.frame.size)
        
        // for customization
        let context = UIGraphicsGetCurrentContext()
        
        arrLines.forEach { (line) in
            for (first, second) in line.enumerated() {
                if first == 0 {
                    context?.move(to: second)
                } else {
                    context?.addLine(to: second)
                }
            }
        }
                
        // style of the line
        context?.setLineCap(CGLineCap.butt)
        
        // width
        context?.setLineWidth(5)
        
        // set the color
        let red: CGFloat = 0 // 0...1
        let green: CGFloat = 0
        let blue: CGFloat = 0
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1)
        
        // strike the path
        context?.strokePath()
        
        drawingPad.image?.draw(in: view.frame)
        
        drawingPad.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
    }
    
}
