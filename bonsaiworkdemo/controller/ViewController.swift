//
//  ViewController.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 16.05.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var feedbackLabel: UILabel!
    var buttonTitle: String?
    
    let waterAmountPerSet: Double = 200
    let restAmount: Double = 100
    
    lazy var waterBucket = WaterBucket(waterAmount: waterAmountPerSet, restAmount: restAmount)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterLabel.text = "\(waterAmountPerSet)"
        feedbackLabel.alpha = 0
    }
    
    @IBAction func mainButtonPressed(_ sender: UIButton) {
        waterBucket.updateButtonLabel = { givingNow in
            if givingNow {
                self.mainButton.setTitle("Stop", for: .normal)
            } else {
                self.mainButton.setTitle("Start", for: .normal)
            }
        }
        waterBucket.triggerWaterBucket(initialWaterAmount: waterAmountPerSet, initialRestAmount: restAmount)
        waterBucket.updateWaterLabel = { time in
            self.waterLabel.text = self.timeString(time: time)
        }
        waterBucket.feedback = { done in
            self.giveFeedback(done)
        }
    }
    
    //MARK: - TimerLabel Methods
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    //MARK: - Feedback Methods
    
    func giveFeedback(_ doneToday: Bool) {
        feedbackLabel.alpha = 1
        if doneToday {
            feedbackLabel.text = "Enough for today. Go have fun!"
            fadeOut(with: feedbackLabel, delay: 2.0)
        }
    }
    
    //MARK: - Animation Methods
    
    func fadeOut(with label: UIView, delay: TimeInterval) {
        let duration = 1.0
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            label.alpha = 0
        }, completion: nil)
    }
    
}

