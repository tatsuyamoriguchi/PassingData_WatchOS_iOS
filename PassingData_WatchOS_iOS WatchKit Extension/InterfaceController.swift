//
//  InterfaceController.swift
//  PassingData_WatchOS_iOS WatchKit Extension
//
//  Created by Tatsuya Moriguchi on 9/15/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class InterfaceController: WKInterfaceController {

    let motion = CMMotionManager()
    var timer = Timer()
    var intervalN = 10.0
    
    @IBOutlet weak var intervalValueLabel: WKInterfaceLabel!
    @IBOutlet weak var xValueLabel: WKInterfaceLabel!
    @IBOutlet weak var yValueLabel: WKInterfaceLabel!
    @IBOutlet weak var zValueLabel: WKInterfaceLabel!
    
    
    @IBAction func startButtonAction() {
      getAccelerometerData(sliderValue: intervalN)
  
    }
    
    @IBAction func endButtonAction() {
          motion.stopAccelerometerUpdates()
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        intervalValueLabel.setText(String(intervalN))
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func getAccelerometerData(sliderValue: Double) {
        // Check to see if the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = sliderValue/60.0 // 60 Hz update frequency
            self.motion.startAccelerometerUpdates()
            
            // Configure a timer to fetchthe data.
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true, block: {(timer) in
                // Get the accelerometer data.
                if let data = self.motion.accelerometerData {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    
                    // Display the accelerometer data on UI.
                    self.xValueLabel.setText(String(x))
                    self.yValueLabel.setText(String(y))
                    self.zValueLabel.setText(String(z))
                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .default)
        }
        
    }

}
