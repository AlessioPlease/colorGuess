//
//  Color.swift
//  Color guess
//
//  Created by Alessio De Gaetano on 21/02/2020.
//  Copyright © 2020 Alessio De Gaetano. All rights reserved.
//

import Foundation

class RandomColor {
    
    private var rRandom: Double = 0
    private var gRandom: Double = 0
    private var bRandom: Double = 0
    
    
    
    init() {
        self.rRandom = Double.random(in: 0..<1)
        self.gRandom = Double.random(in: 0..<1)
        self.bRandom = Double.random(in: 0..<1)
    }
    
    
    
    func newRandomColors() {
        self.rRandom = Double.random(in: 0..<1)
        self.gRandom = Double.random(in: 0..<1)
        self.bRandom = Double.random(in: 0..<1)
        print(rRandom, gRandom, bRandom)
    }
    
    
    
    func getrRandom() -> Double {
        return self.rRandom
    }
    
    func getgRandom() -> Double {
        return self.gRandom
    }
    
    func getbRandom() -> Double {
        return self.bRandom
    }
}
