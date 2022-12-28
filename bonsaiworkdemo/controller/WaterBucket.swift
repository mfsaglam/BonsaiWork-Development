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
    //TODO: REMINDER: dailyCounter looks up that if the number is even or odd. so you may need to multiply it. Because it need 2 times more for one is workTime, other is for restTime
    var dailyNeed = 4 // this needs to be driven by TREE KIND
    
    //MARK: - Counter Logic Methods and instances
    private var timer = Timer()
    
    func triggerTimer(workTime: Int, restTime: Int) {
        let time = isWorkTime ? workTime : restTime
        if isTimeRunning {
            stopTimer(time)
        } else {
            //TODO: tree dailyNeed needed here
            if dailyCounter < dailyNeed {
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
    
    var isTimeRunning: Bool {
        return timer.isValid 
    }
    
    var isWorkTime: Bool {
        return dailyCounter % 2 == 0
    }
    
}
