//
//  Bonsai.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 11.06.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import Foundation

struct Bonsai {
    
    var name: String?
    var setNeedDaily: Int?
    private var age = 0
    
    mutating func checkStatus(for currentWater: Int) {
        if setNeedDaily != nil {
            if currentWater == setNeedDaily! {
                age += 1
                print("tree got aged! age at \(age)")
            }
        } else {
            print("waterNeed and age is currently nil")
        }
    }
    
    init (name: String, waterNeed: Int){
        self.name = name
        self.setNeedDaily = waterNeed
    }
    
}
