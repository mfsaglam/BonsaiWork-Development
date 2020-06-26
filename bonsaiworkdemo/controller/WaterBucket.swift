//
//  Countdown.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 10.06.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import Foundation

class WaterBucket {
        
    var updateWaterLabel: ((Int) -> Void)?
    
    var dailyCounter = 0
    
    var isWorkTime: Bool {
        if dailyCounter % 2 == 0 {
            return true
        } else {
            return false
        }
    }
    
    var isTimeRunning: Bool {
        if timer.isValid {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - Counter Logic Methods
    private var timer = Timer()
    
    func triggerTimer(workTime: Int, restTime: Int) {
        let time = isWorkTime ? workTime : restTime
        if isTimeRunning {
            stopTimer(time)
        } else {
            if dailyCounter < 3 {
                startTimer(time)
            } else {
                print("Enough for today")
            }
        }
    }
    
    private func startTimer(_ currentTime: Int) {
        var timeLeft = currentTime
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            if timeLeft > 0 {
                timeLeft -= 1
                self.updateWaterLabel?(timeLeft)
            } else {
                self.stopTimer(currentTime)
                self.dailyCounter += 1
            }
        })
    }
    
    private func stopTimer(_ currentTime: Int) {
        timer.invalidate()
        updateWaterLabel?(currentTime)
    }
    
}
