//
//  ViewController.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 16.05.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
        
    //MARK: - UI Elements
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    //MARK: - Image Outlets
    
    @IBOutlet weak var potImageView: UIImageView!
    @IBOutlet weak var treeImageView: UIImageView!
    
    
    //MARK: - VC Instances
    
    //TODO: These numbers to be driven by the kind of tree or userDefaults
    let waterAmountPerSupply: Int = 5
    let restAmount: Int = 2

    //MARK: - Model Objects
    
    var waterBucket = WaterBucket()
    
    //MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(waterBucket.daypass.today)
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
        
    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updatedImageName() -> (pot: String, age: String, status: String) {
        
        //TODO: Figure out that
        return (pot: "pot", age: "10", status: "healthy")
    }

}

