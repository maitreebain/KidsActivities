//
//  CanvasView.swift
//  drawView
//
//  Created by Tsering Lama on 4/16/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    // public function
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
        
    fileprivate var lines = [[CGPoint]]()
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        

        let newRed   = Double(arc4random_uniform(256))/255.0
        let newGreen = Double(arc4random_uniform(256))/255.0
        let newBlue  = Double(arc4random_uniform(256))/255.0

        context.setStrokeColor(red: CGFloat(newRed), green: CGFloat(newGreen), blue: CGFloat(newBlue), alpha: 1.0)
        context.setLineWidth(5)
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
}

