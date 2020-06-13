//
//  Bonsai.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 11.06.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import Foundation

struct Bonsai {
    
    var setNeedDaily: Int?
    private var age = 0
    enum healthStatus {
        case healthy, dying, almostDead, dead
    }
    
    //MARK: - Checking Methods
    
    mutating func checkAge(for currentWater: Int) -> Int {
        if setNeedDaily != nil {
            if currentWater == setNeedDaily! {
                age += 1
                return age
            } else {
                return age
            }
        } else {
            fatalError("waterNeed is currently nil")
        }
    }
    
    mutating func checkHealth(lastTime: Int, now: Int) -> healthStatus {
        let difference = now - lastTime
        switch difference {
        case 0:
            return .healthy
        case 1:
            return .healthy
        case 2:
            return .dying
        case 3:
            return .almostDead
        default:
            return .dead
        }
    }
    
    //MARK: - Init Methods
    
    init (waterNeed: Int){
        self.setNeedDaily = waterNeed
    }
    
}
