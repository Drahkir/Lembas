//
//  Ingredient.swift
//  Lembas
//
//  Created by Rikhard Mikac on 1/14/16.
//  Copyright © 2016 Sleepy Puppy LLC. All rights reserved.
//

import Foundation

class Ingredient {
    var name = ""
    var oldQty = 0.0
    var newQty = 0.0
    var bakingCalculatorModel = BakingCalculatorModel(oldQty: 0, oldYield: 0, newYield: 0)
    
    init(name: String, oldQty: Double) {
        self.name = name
        self.oldQty = oldQty
    }
    
    init(name: String, oldQty: Double, newQty: Double) {
        self.name = name
        self.oldQty = oldQty
        self.newQty = newQty
    }
}