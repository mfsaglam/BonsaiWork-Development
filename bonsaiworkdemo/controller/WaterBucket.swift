//
//  Countdown.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 10.06.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import Foundation

class WaterBucket {
    
    var tree = Bonsai(waterNeed: 1)
    var waterAmount: Double?
    var todaysSupply = 0
    var updateWaterLabel: ((Double) -> Void)?
    var updateButtonLabel: ((Bool) -> Void)?
    var feedback: ((Bool) -> Void)?
    var timer = Timer()
    var isGivingWater = false
    var isRestTime = false
    var doneToday = false
    
    
    func triggerWaterBucket(initialWaterAmount: Double, initialRestAmount: Double) {
        let initialWaterInfo = ["water": initialWaterAmount, "rest": initialRestAmount]
        if !isRestTime {
            if isGivingWater {
                stopGivingWater(with: initialWaterAmount)
                updateWaterLabel?(initialWaterAmount) //waterLabelClosure !!!
            } else {
                isGivingWater = true
                updateButtonLabel?(isGivingWater) // resttime stop update for button !!!
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(water), userInfo: initialWaterInfo, repeats: true)
            }
        } else {
            if isGivingWater {
                stopGivingWater(with: initialRestAmount)
            } else {
                isGivingWater = true
                updateButtonLabel?(isGivingWater) // worktime stop update for button !!!
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(water), userInfo: initialWaterInfo, repeats: true)
            }
        }
    }
    
    // stops and invalidates the timer, and resets the workFor time
    func stopGivingWater(with waterSet: Double) {
        isGivingWater = false
        timer.invalidate()
        waterAmount = waterSet
        updateWaterLabel?(waterSet) //!!!!
        updateButtonLabel?(isGivingWater) // start update for button !!!
    }
    
    //MARK: - @objc Timer Method
    
    @objc func water() {
        if waterAmount != nil {
            if waterAmount! > 0 {
                waterAmount! -= 1
                updateWaterLabel?(waterAmount!)
            } else if waterAmount == 0 {
                isRestTime.toggle()
                if let info = timer.userInfo as? [String : Double] {
                    if isRestTime {
                        giveUserFeedBack()
                        waterAmount = info["rest"]
                        updateWaterLabel?(waterAmount ?? 0)
                        // set tme with restTime "userInfo used to pass data to selector function"
                    } else {
                        giveUserFeedBack()
                        waterAmount = info["water"]
                        updateWaterLabel?(waterAmount ?? 0)
                        //set the time on workTime
                    }
                }
            }
        } else {
            print("time probably didn't set, it is nil.")
        }
    }
    
    func waterAmountCheckForDaily() {
        if let dailyNeed = tree.setNeedDaily {
            if todaysSupply < dailyNeed {
                todaysSupply += 1
                print("supplyForNow \(todaysSupply)")
            } else {
                stopGivingWater(with: 0)
                doneToday = true
                feedback?(doneToday) //!!!
                tree.checkAge(for: todaysSupply)
            }
        }
    }
    
//MARK: - Init methods
    
    init(waterAmount: Double, restAmount: Double) {        
        self.waterAmount = !isRestTime ? waterAmount : restAmount
    }
    
//MARK: - Feedback Methods
    
    func giveUserFeedBack() {
        waterAmountCheckForDaily()
        if isRestTime {
            print("Now it is REST time")
        } else if !doneToday {
            print("Get back to WORK!")
        } else {
            print("exit giveUserFeedback")
            return
        }
    }
    
}
