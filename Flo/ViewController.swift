//
//  ViewController.swift
//  Flo
//
//  Created by Martin Matějka on 05.09.16.
//  Copyright © 2016 Martin Matějka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Counter outlets
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    //Label outlets
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var isGraphViewShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPushButton(_ button: Push_ButtonView) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            counterViewTap(nil)
        }
    }

    @IBAction func counterViewTap(_ gesture:UITapGestureRecognizer?) {
        if (isGraphViewShowing) {
            
            //hide Graph
            UIView.transition(from: graphView,
                                      to: counterView,
                                      duration: 1.0,
                                      options: UIViewAnimationOptions.transitionFlipFromLeft,
                                      completion:nil)
        } else {
            
            //show Graph
            setupGraphDisplay()
            UIView.transition(from: counterView,
                                      to: graphView,
                                      duration: 1.0,
                                      options: UIViewAnimationOptions.transitionFlipFromRight,
                                      completion: nil)
            
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    func setupGraphDisplay() {
        
        //Use 7 days for graph - can use any number,
        //but labels and sample data are set up for 7 days
        let noOfDays:Int = 7
        
        //1 - replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(graphView.graphPoints.max())"
        
        //3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, +)
            / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        //set up labels
        //day of week labels are set up in storyboard with tags
        //today is last day of the array need to go backwards
        
        //4 - get today's day number
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let componentOptions:NSCalendar.Unit = .weekday
        let components = (calendar as NSCalendar).components(componentOptions,
                                             from: Date())
        var weekday = components.weekday
        
        let days = ["S", "N", "P", "Ú", "S", "Č", "P"]
        
        //5 - set up the day name labels with correct day
        for i in (1...days.count).reversed() {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                labelView.text = days[(weekday! - 1)]
                if weekday! < 0 {
                    weekday = days.count - 1
                }
            }
        }
        graphView.isHidden = false
    }

}

