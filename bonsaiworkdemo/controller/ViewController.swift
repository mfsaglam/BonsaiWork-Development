//
//  ViewController.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 16.05.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let countdown = Countdown()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdown.resetTimer()
        timeLabel.text = "\(countdown.timeLeft ?? 25)"
    }
    
    @IBAction func mainButtonPressed(_ sender: UIButton) {
        countdown.startTimer()
        countdown.isTimerOff.toggle()
        mainButton.setTitle(updateButtonText(), for: .normal)
        countdown.updateTimeLabel = { time in
            self.timeLabel.text = "\(time)"
            self.mainButton.setTitle(self.updateButtonText(), for: .normal)
        }
    }
    
    func updateButtonText() -> String {
        if countdown.isTimerOff {
            return "Start"
        } else {
            return "Stop"
        }
    }
    
}

