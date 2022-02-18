//
//  BoundingBox.swift
//  Monte Carlo Integration
//
//  Created by Jeff Terry on 12/31/20.
//

import Foundation
import SwiftUI

class BoundingBox: NSObject {
    
    /// Area
    ///
    /// - Parameters:
    ///   - lowerBound: lower bound of integral
    ///   - upperBound: upper bound of integral
    ///   - min: lowest y-axis value within which you want to intergrate (take this value to be zero, unless the function goes below the x-axis, in which case this should be the minimum value of the function in within the bounds of integration)
    ///   - max: highest y-axis value within which you want to intergrate (should be the maximum value of the function within the bounds of integration)
    /// - Returns: Area of box
    func Area(lowerBound: Double, upperBound: Double, min: Double, max: Double) -> Double {
        
        let Area = (upperBound - lowerBound) * (max - min)
        
        return (Area)
    }
}

