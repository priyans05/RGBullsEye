//
//  TimeCounter.swift
//  RGBullsEye
//
//  Created by PRIYANS on 31/3/20.
//  Copyright © 2020 PRIYANS. All rights reserved.
//

import Combine
import Foundation

class TimeCounter: ObservableObject {
    var timer: Timer?
    
    @Published var counter = 0
    
    @objc func updateCounter() {
        counter += 1
    }
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        counter = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
}
