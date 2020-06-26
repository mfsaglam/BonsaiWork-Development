//
//  ViewController.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 16.05.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    //MARK: - UI Elements
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    //MARK: - Image Outlets
    @IBOutlet weak var potImageView: UIImageView!
    @IBOutlet weak var treeBodyImageView: UIImageView!
    @IBOutlet weak var leavesImageView: UIImageView!
    
    //MARK: - VC Instances
    
    let waterAmountPerSupply: Int = 15000
    let restAmount: Int = 5000

    //MARK: - Model Objects
    
    var waterBucket = WaterBucket()
    
    //MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterLabel.text = timeString(Double(waterAmountPerSupply))
    }
    
    //MARK: - mainButton Method
    
    @IBAction func mainButtonPressed(_ sender: UIButton) {
        waterBucket.triggerTimer(workTime: waterAmountPerSupply, restTime: restAmount)
        updateButtonLabel()
        waterBucket.updateWaterLabel = { time in
            self.waterLabel.text = self.timeString(Double(time))
            if !self.waterBucket.isTimeRunning {
                self.updateButtonLabel()
            }
        }
    }
    
    //MARK: - UI Update Methods
    
    func updateButtonLabel() {
        if waterBucket.isTimeRunning {
            mainButton.setTitle("Stop", for: .normal)
        } else {
            mainButton.setTitle("Start", for: .normal)
        }
    }
    
    //MARK: - timerLabel Method
    
    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }

}

