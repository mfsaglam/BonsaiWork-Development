//
//  Date.swift
//  bonsaiWorkDemo
//
//  Created by Gamze on 23.06.2020.
//  Copyright © 2020 Gamze. All rights reserved.
//

import Foundation

struct DateStruct {
    
    let defaults = UserDefaults.standard
    let now = Int(Date().timeIntervalSince1970) / 86400
    lazy var lastRun = defaults.integer(forKey: "lastRunAsDays")
    lazy var difference = now - lastRun
    
    func saveLastRun() {
        let today = Int((Date().timeIntervalSince1970) / 86400)
        defaults.set(today, forKey: "lastRunAsDays")
    }
    
}
