//
//  ViewController.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 16.05.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
    let workTime = 25
    let restTime = 5
    lazy var counter = Countdown(workFor: workTime, restFor: restTime)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "\(workTime)"
    }
    
    @IBAction func mainButtonPressed(_ sender: UIButton) {
        //trigger the timer
        counter.triggerTimer(initialWorkTime: workTime, initialRestTime: restTime)
        //update button title depending on the timer
        mainButton.setTitle(buttonTitle(), for: .normal)
        //update time label
        counter.updateTheTitle = { time in
            self.timeLabel.text = "\(time)"
        }
    }
    
    func buttonTitle() -> String {
        if counter.isTimerOn {
            return "Stop"
        } else {
            return "Start"
        }
    }
    
    
}

