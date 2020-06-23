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
    @IBOutlet weak var potImageView: UIImageView!
    @IBOutlet weak var treeBodyImageView: UIImageView!
    @IBOutlet weak var leavesImageView: UIImageView!
    var buttonTitle: String?
    
    let waterAmountPerSupply: Double = 15
    let restAmount: Double = 5
    let daysPassed = 9
    
    var dateChecker = DateStruct()
    lazy var waterBucket = WaterBucket(waterAmount: waterAmountPerSupply, restAmount: restAmount)
    
    //MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterLabel.text = "\(timeString(waterAmountPerSupply))"
        feedbackLabel.alpha = 0
        dateChecker.saveLastRun()
        print(dateChecker.difference)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let status = waterBucket.tree.checkHealth(dateChecker.difference)
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
        if let statusImage = UIImage(named: "tree_10_\(status)") {
            crossFade(to: statusImage, delay: 0.5)
        } else {
            //TODO: Make the tree die in here
        }
    }
    
    //MARK: - Animation Methods
    
    func fadeOut(with label: UIView, delay: TimeInterval) {
        let duration = 2.0
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            label.alpha = 0
        }, completion: nil)
    }
    
    func crossFade(to secondImage: UIImage, delay: TimeInterval) {
        let duration = 3.0
        UIView.transition(with: leavesImageView, duration: duration, options: .transitionCrossDissolve,
        animations: { self.leavesImageView.image = secondImage }, completion: nil)
    }
    
}

