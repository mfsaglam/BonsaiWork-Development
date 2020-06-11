//
//  Countdown.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 10.06.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import Foundation

class Countdown {
    
    var time: Int?
    var updateTheTitle: ((Int) -> Void)?
    var timer = Timer()
    var isTimerOn = false
    var isRestTime = false
    
    //deals with starting and stopping timer only
    func triggerTimer(initialWorkTime: Int, initialRestTime: Int) {
        let timesInfo = ["work": initialWorkTime, "rest": initialRestTime]
        if !isRestTime {
            if isTimerOn {
                stopTimer(with: initialWorkTime)
                updateTheTitle?(initialWorkTime)
            } else {
                isTimerOn = true
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fire), userInfo: timesInfo, repeats: true)
            }
        } else {
            if isTimerOn {
                stopTimer(with: initialRestTime)
                updateTheTitle?(initialRestTime)
            } else {
                isTimerOn = true
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fire), userInfo: timesInfo, repeats: true)
            }
        }
        
    }
    
    // stops and invalidates the timer, and resets the workFor time
    func stopTimer(with timeSet: Int) {
        isTimerOn = false
        timer.invalidate()
        time = timeSet
    }
    
    @objc func fire() {
        if time != nil {
            if time! > 0 {
                time! -= 1
                updateTheTitle?(time!)
            } else if time == 0 {
                isRestTime.toggle()
                if let info = timer.userInfo as? [String : Int] {
                    if isRestTime {
                        time = info["rest"]
                        // set tme with restTime
                    } else {
                        time = info["work"]
                        //set the time on workTime
                    }
                }
            }
        } else {
            print("timeleft probably didn't set, it is nil.")
        }
    }
    
    //init methods
    
    init(workFor: Int, restFor: Int) {
        if !isRestTime {
            self.time = workFor
        } else {
            self.time = restFor
        }
    }
    
}
