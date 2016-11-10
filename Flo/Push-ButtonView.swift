//
//  Push-ButtonView.swift
//  Flo
//
//  Created by Martin Matějka on 05.09.16.
//  Copyright © 2016 Martin Matějka. All rights reserved.
//

import UIKit

@IBDesignable
class Push_ButtonView: UIButton {
    @IBInspectable var fillColor: UIColor = UIColor.blue
    @IBInspectable var isAddButton: Bool = true

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2))
        
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2))
        
        if isAddButton {
            //move to the start of the vertical stroke
            plusPath.move(to: CGPoint(x: bounds.width/2,
                                         y: bounds.height/2 - plusWidth/2))
            
            //add the end point to the vertical stroke
            plusPath.addLine(to: CGPoint(x: bounds.width/2,
                                            y: bounds.height/2 + plusWidth/2))
        }
       
        
        //set the stroke color
        UIColor.white.setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
    }
    
}
