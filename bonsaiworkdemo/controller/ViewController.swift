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
    
    let waterAmountPerSupply: Double = 15
    let restAmount: Double = 5
    let lastOpen = 1
    let today = 4
    
    lazy var waterBucket = WaterBucket(waterAmount: waterAmountPerSupply, restAmount: restAmount)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterLabel.text = "\(timeString(waterAmountPerSupply))"
        feedbackLabel.alpha = 0
        let status = waterBucket.tree.checkHealth(lastTime: lastOpen, now: today)
        updateTreeImage(accordingTo: status)
    }
    
    //MARK: - Main Button Pressed
    
    @IBAction func mainButtonPressed(_ sender: UIButton) {
        waterBucket.updateButtonLabel = { givingNow in
            if givingNow {
                self.mainButton.setTitle("Stop", for: .normal)
            } else {
                self.mainButton.setTitle("Start", for: .normal)
            }
        }
        waterBucket.triggerWaterBucket(initialWaterAmount: waterAmountPerSupply, initialRestAmount: restAmount)
        waterBucket.updateWaterLabel = { time in
            self.waterLabel.text = self.timeString(time)
        }
        waterBucket.feedback = { done in
            self.giveFeedback(done)
        }
    }
    
    //MARK: - TimerLabel Methods
    
    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    //MARK: - Feedback Methods
    
    func giveFeedback(_ doneToday: Bool) {
        feedbackLabel.alpha = 1
        if doneToday {
            feedbackLabel.text = "Enough for today. Go have fun!"
            fadeOut(with: feedbackLabel, delay: 5.0)
        }
    }
    
    func updateTreeImage(accordingTo status: Bonsai.healthStatus) {
        print("image set to Bonsai_\(status)")
    }
    
    //MARK: - Animation Methods
    
    func fadeOut(with label: UIView, delay: TimeInterval) {
        let duration = 2.0
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            label.alpha = 0
        }, completion: nil)
    }
    
//    func crossFade(to secondImage: UIImage, delay: TimeInterval) {
//        let duration = 10.0
//        UIView.transition(with: imageTree, duration: duration, options: .transitionCrossDissolve,
//        animations: { self.imageTree.image = secondImage }, completion: nil)
//    }
    
}

