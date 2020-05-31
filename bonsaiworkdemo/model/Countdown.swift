//
//  Countdown.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 16.05.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import Foundation

class Countdown {
    
    var timer = Timer()
    var timeLeft: Int?
    var isTimerOff = true
    var updateTimeLabel: ((Int) -> Void)?
    
    
    func resetTimer() {
        timer.invalidate()
        timeLeft = setTime()
        isTimerOff = true
        updateTimeLabel?(timeLeft ?? 5)
    }
    
    func startTimer() {
        if isTimerOff {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        } else {
            resetTimer()
        }
    }
    
    
    @objc func onTimerFires() {
        if timeLeft != nil {
            if timeLeft! > 0 {
                timeLeft! -= 1
                updateTimeLabel?(timeLeft!)
            } else {
                resetTimer()
            }
        } else {
            print("timeleft found to be nil")
        }
    }
    
    func setTime() -> Int {
        return 20
    }
    
    // Format the time using the func below
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
